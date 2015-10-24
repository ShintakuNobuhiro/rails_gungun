require 'spec_helper'

describe Level do
  before do
    @level = Level.new(value:1, sufficiency:1)
  end
  
  subject { @level }
   
  it { should respond_to(:value) }
  it { should respond_to(:sufficiency) }
    
  it { should be_valid }
    
  describe "when value is less than 1" do
      before {@level.value = 0 }
      it { should_not be_valid }
  end
   
  describe "when sufficiency is less than 0" do
       before {@level.sufficiency = -1 }
       it { should_not be_valid }
  end
  
  describe "when the same value is exist" do
    before do
      level_with_same_value = @level.dup
      level_with_same_value.save
    end
    it { should_not be_valid }
  end
end