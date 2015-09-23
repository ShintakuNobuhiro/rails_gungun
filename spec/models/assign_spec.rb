require 'spec_helper'

describe Assign do
    before do
        @mission = Mission.create(level_id:1, category_id:1, description:"説明文")
        @assign = @mission.assigns.build(user_id:1)
    end
    
    subject { @assign }
    
    it { should respond_to(:mission_id) }
    it { should respond_to(:user_id) }
    
    it { should be_valid }
    
    describe "when mission_id is not present" do
        before { @assign.mission_id = nil }
        it { should_not be_valid }
    end
    
    describe "when user_id is not present" do
        before { @assign.user_id = nil }
        it { should_not be_valid }
    end
end
