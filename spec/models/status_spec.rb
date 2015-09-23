require 'spec_helper'

describe Status do
    before do
        @user = User.create(name: "Example User", email: "user@example.com",
                            password: "foobar", password_confirmation: "foobar",
                            card_id:"example")
        @status = @user.statuses.build(mission_id:1, experience:1)
    end
    
    subject { @status }

    
    it { should respond_to (:user_id) }
    it { should respond_to (:mission_id) }
    it { should respond_to (:experience) }
    its(:user) { should eq @user }
    
    it { should be_valid }
end
