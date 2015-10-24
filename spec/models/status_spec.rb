require 'spec_helper'

describe Status do
    before do
        @user = User.create(name: "Example User", email: "user@example.com",
                            password: "foobar", password_confirmation: "foobar",
                            card_number:"example")
        @category = Category.create(name: "健康")
        @status = @user.statuses.build(category_id: @category.id, experience:1, recent_experience:10)
    end
    
    subject { @status }

    it { should respond_to(:user_id) }
    it { should respond_to(:category_id) }
    it { should respond_to(:experience) }
    it { should respond_to(:recent_experience) }
    its(:user) { should eq @user }
    its(:category) { should eq @category }
    
    it { should be_valid }
    
    describe "when user_id is not present" do
        before { @status.user_id = nil }
        it { should_not be_valid }
    end
    
    describe "when category_id is not present" do
        before { @status.category_id = nil }
        it { should_not be_valid }
    end
    
    describe "when experience is less than 0" do
        before { @status.experience = -1 }
        it { should_not be_valid }
    end
    
    describe "when recent_experience is less than 0" do
        before { @status.experience = -1 }
        it { should_not be_valid }
    end
    
    describe "when the same category is registered" do
        before do
            status_with_same_category_id = @user.statuses.build(category_id: @category.id, experience:1, recent_experience:10)
            status_with_same_category_id.save
        end
        it { should_not be_valid }
    end
end
