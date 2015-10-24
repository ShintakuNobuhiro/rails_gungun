require 'spec_helper'

describe Assign do
    before do
        @mission = Mission.create(level_id:1, category_id:1, description:"説明文")
        @user = User.create(name:"Example User", email: "user@example.com",
                                 password: "foobar", password_confirmation: "foobar",
                                 card_number:"example")
        @assign = @mission.assigns.build(user_id: @user.id, achievement: true)
    end
    
    subject { @assign }
    
    it { should respond_to(:mission_id) }
    it { should respond_to(:user_id) }
    it { should respond_to(:achievement) } 
    its(:mission) { should eq @mission }
    its(:user) { should eq @user }
    
    it { should be_valid }
    
    describe "when mission_id is not present" do
        before { @assign.mission_id = nil }
        it { should_not be_valid }
    end
    
    describe "when user_id is not present" do
        before { @assign.user_id = nil }
        it { should_not be_valid }
    end
    
    describe "when achievement is not present" do
        before { @assign.achievement = nil }
        it { should_not be_valid }
    end
    
    describe "when the same mission is registered" do
        before do
            assign_with_same_mission_id = @user.assigns.build(mission_id: @mission.id, achievement: true)
            assign_with_same_mission_id.save
        end
        it { should_not be_valid }
    end
end
