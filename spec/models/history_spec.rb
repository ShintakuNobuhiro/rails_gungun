require 'spec_helper'

describe History do
    before do
        @user = User.create(name: "Example User", email: "user@example.com",
                            password: "foobar", password_confirmation: "foobar",
                            card_number:"example")
        @mission = Mission.create(level_id: 1, category_id: 1, description: "説明文")
        @history = @user.histories.build(mission_id: @mission.id, experience: 10)
    end
    
    subject { @history }
    
    it { should respond_to (:user_id) }
    it { should respond_to (:mission_id) }
    it { should respond_to (:experience) }
    its(:user) { should eq @user }
    its(:mission) { should eq @mission }
    
    it { should be_valid }
    
    describe "when user_id is not present" do
        before { @history.user_id = nil }
        it { should_not be_valid }
    end
    
    describe "when mission_id is not present" do
        before { @history.mission_id = nil }
        it { should_not be_valid }
    end
    
    describe "when experience is less than 0" do
        before { @history.experience = -1 }
        it { should_not be_valid }
    end
end
