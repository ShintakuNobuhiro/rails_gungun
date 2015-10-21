class User < ActiveRecord::Base
  belongs_to :role
  has_many :assigns
  has_many :histories
  has_many :statuses
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  after_create :create_statuses
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def cell
    statuses = self.statuses
    total_experience = 0
    statuses.each do |status|
      total_experience += status.experience
    end
    cell = total_experience / 2
  end
  
  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
    
    def create_statuses
      categories = Category.all
      categories.each do |category|
        self.statuses.create(category_id: category.id, experience: 0, recent_experience: 0)
      end
    end
end