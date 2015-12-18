require 'spec_helper'

describe "POST /api/histories" do
  subject { page }
  before do
    @user = User.create(name: "Example User", email: "user@example.com",
                        password: "foobar", password_confirmation: "foobar",
                        card_number:"example")
    @category = Category.create(name: "健康")
    @level = Level.create(value:2, sufficiency:100)
    @mission1 = Mission.create(id:20, level_id: @level.id, category_id: @category.id, description:"説明文")
    @mission2 = Mission.create(id:18, level_id: @level.id, category_id: @category.id, description:"説明文")
  end
  
  describe "POST /api/histories.json" do
    let(:request_header) do
      { 'CONTENT_TYPE' => 'application/json' }
    end
    
    let(:json_body) do
      '{"card_number":"example","password":"foobar", "mission_ids":[20,18]}' 
    end
    
    it "should return ok200" do
      post "/api/histories.json", json_body, request_header
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    
    it "should return valid json sata" do
      post "/api/histories.json", json_body, request_header
      jsons = JSON.parse(response.body)
      if jsons["card_number"] == (@user.card_number)
        mission_ids = jsons["mission_ids"]
        expect(mission_ids).to match_array [@mission1.id, @mission2.id]
      end
    end
    
    
    let(:json_body_invalid_user) do
      '{"card_number":"example_invalid","password":"foobar", "mission_ids":[20,18]}' 
    end
    
    let(:json_body_invalid_password) do
      '{"card_number":"example","password":"foobar_invalid", "mission_ids":[20,18]}' 
    end
    
    let(:json_body_invalid_mission) do
      '{"card_number":"example","password":"foobar", "mission_ids":[10,18]}' 
    end
    
    it "should return 404 Not Found user not found" do
      post "/api/histories.json", json_body_invalid_user, request_header
      jsons = JSON.parse(response.body)
      expect(jsons["detail"]).to eq("user not found with card_number=example_invalid")
    end
    
    it "should return 404 Not Found invalid password" do
      post "/api/histories.json", json_body_invalid_password, request_header
      jsons = JSON.parse(response.body)
      expect(jsons["detail"]).to eq("invalid password")
    end
    
    it "should return 404 Not Found mission not found" do
      post "/api/histories.json", json_body_invalid_mission, request_header
      jsons = JSON.parse(response.body)
      expect(jsons["detail"]).to eq("missions not found with mission_ids=[10, 18]")
    end
  end
end
