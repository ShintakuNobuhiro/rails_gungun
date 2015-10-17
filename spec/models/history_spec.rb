require 'spec_helper'

describe History do
    before do
        @user = User.create(name: "Example User", email: "user@example.com",
                            password: "foobar", password_confirmation: "foobar",
                            card_number:"example")
        @history = @user.histories.build(mission_id:1, experience:10)
    end
    
    subject { @history }
    
    it { should respond_to (:user_id) }
    it { should respond_to (:mission_id) }
    it { should respond_to (:experience) }
    its(:user) { should eq @user }
    
    it { should be_valid }
end
