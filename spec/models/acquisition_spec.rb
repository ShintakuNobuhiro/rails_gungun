require 'spec_helper'

describe Acquisition do
    before do
        @mission = Mission.create(level_id:1, category_id:1, description:"説明文")
        @acquisition = @mission.acquisitions.build(category_id:1, experiences:1)
    end
    
    subject { @acquisition }
    
    it { should respond_to(:category_id) }
    it { should respond_to(:mission_id) }
    it { should respond_to(:experiences) }
    its(:mission) { should eq @mission }
    
    it { should be_valid }
    
    describe "when category_id is not present" do
        before { @acquisition.category_id = nil }
        it { should_not be_valid }
    end
    
    describe "when mission_id is not present" do
        before { @acquisition.mission_id = nil }
        it { should_not be_valid }
    end
    
    describe "when experiences is less than 0" do
        before { @acquisition.experiences = 0 }
        it { should_not be_valid }
    end
end
