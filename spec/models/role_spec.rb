require 'spec_helper'

describe Role do
    before do
        @role = Role.new(name:"伊藤")
    end
    
    subject{ @role }
    
    it { should respond_to(:name) }
    it { should be_valid }
end
