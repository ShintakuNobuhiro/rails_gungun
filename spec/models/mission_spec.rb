require 'spec_helper'

describe Mission do
    before do
      @level = Level.create(value:1, sufficiency:1) 
      @mission = @level.missions.build(description:"説明文", category_id:1) 
    end
    
    subject { @mission }
      
    it { should respond_to(:level_id) }
    it { should respond_to(:description) }
    it { should respond_to(:category_id) }
    its(:level) { should eq @level }
  
    it { should be_valid }
  
    describe "when level_id is not present" do
        before { @mission.level_id = nil }
        it { should_not be_valid }
    end
      
    describe "with blank description" do
        before { @mission.description = " " }
        it { should_not be_valid }
    end
    
    describe "with description that is too long" do
        before { @mission.description = "a"*21 }
        it { should_not be_valid }
    end
    
    describe "when category_id is not present" do
        before { @mission.category_id = nil }
        it { should_not be_valid }
    end
end
