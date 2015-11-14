require 'spec_helper'

describe "POST /api_categories" do
  subject { page }
  before do
    @user = User.create(name: "Example User", email: "user@example.com",
                        password: "foobar", password_confirmation: "foobar",
                        card_number:"example")
    @category = Category.create(name: "健康")
    @level = Level.create(value:2, sufficiency:100)
    @mission = Mission.create(level_id: @level.id, category_id: @category.id, description:"説明文")
  end
  
  describe "POST /api/categories.json" do
    # headerとbodyをつくってpathにPOST
    let(:request_header) do
      { 'CONTENT_TYPE' => 'application/json' }
    end
      
    let(:json_body) do
      '{"card_number":"example","password":"foobar"}' 
    end
      
    it "should return ok200" do
      post "/api/categories.json", json_body, request_header
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    
    
    it "should return valid json data" do
      post "/api/categories/#{@category.id}.json", json_body, request_header
      jsons = JSON.parse(response.body)
      expect(jsons["name"]).to eq(@category.name)
      levels = jsons["levels"]      
      levels.each do |level|
        
        
      end
    end
  end
end
