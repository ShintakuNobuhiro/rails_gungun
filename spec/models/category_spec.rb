require 'spec_helper'

describe Category do
    before do
        @category = Category.new(name:"健康")
    end
    
    subject { @category }
    
    it { should respond_to(:name) }
    it { should be_valid }
end
