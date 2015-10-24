require 'spec_helper'

describe Role do
    before do
        @role = Role.new(name:"Administrator")
    end
    
    subject{ @role }
    
    it { should respond_to(:name) }
    it { should be_valid }
    
    describe "with blank name" do
        before { @role.name = " " }
        it { should_not be_valid }
    end
end
