require 'spec_helper'

describe Role do
    before do
        @role = Role.new(name:"Administrator", japanese_name:"管理者")
    end
    
    subject{ @role }
    
    it { should respond_to(:name) }
    it { should respond_to(:japanese_name) }
    it { should be_valid }
    
    describe "with blank name" do
        before { @role.name = " " }
        it { should_not be_valid }
    end
    
    describe "with blank japanese_name" do
        before { @role.name = " " }
        it { should_not be_valid }
    end
end
