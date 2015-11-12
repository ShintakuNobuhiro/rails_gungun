require 'spec_helper'

describe "POST /api_categories" do
  subject { page }
  before do
    @user = User.create(name: "Example User", email: "user@example.com",
                        password: "foobar", password_confirmation: "foobar",
                        card_number:"example")
    @mission = Mission.create(level_id:1, category_id:1, description:"説明文")
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
      json = JSON.parse(response.body)
      expect(json["value"]).to eq(@level.value)
      expect(json["sufficiency"]).to eq(@level.sufficiency)
    end
  end
end
