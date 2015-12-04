require 'spec_helper'

describe "POST /api/categories/:category_id" do
  subject { page }
  before do
    @user = User.create(name: "Example User", email: "user@example.com",
                        password: "foobar", password_confirmation: "foobar",
                        card_number:"example")
    @category = Category.create(name: "健康")
    @level = Level.create(value:2, sufficiency:100)
    @mission = Mission.create(level_id: @level.id, category_id: @category.id, description:"説明文")
  end
  
  describe "POST /api/categories/:category_id" do
    let(:request_header) do
      { 'CONTENT_TYPE' => 'application/json' }
    end
      
    let(:json_body) do
      '{"card_number":"example","password":"foobar"}' 
    end
      
    it "should return ok200" do
      post "/api/categories/#{@category.id}.json", json_body, request_header
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    
    
    it "should return valid json data" do
      post "/api/categories/#{@category.id}.json", json_body, request_header
      jsons = JSON.parse(response.body)
      jsons.each do |json|
        expect(jsons["name"]).to eq(@category.name)
        levels = jsons["levels"]      
        levels.each do |level|
          expect(level["value"]).to eq(@level.value)
          missions = level["missions"]
          missions.each do |mission|
            if mission["id"].to_i == (@mission.id)
              expect(mission["description"]).to eq(@mission.description)
            end
          end
        end
      end
    end
    
    let(:json_body_invalid_user) do
      '{"card_number":"example_invalid","password":"foobar"}' 
    end
    
    let(:json_body_invalid_password) do
      '{"card_number":"example","password":"foobar_invalid"}' 
    end

    it "should return 404 Not Found" do
      post "/api/categories/#{@category.id}.json", json_body_invalid_user, request_header
      jsons = JSON.parse(response.body)
      expect(jsons["detail"]).to eq("user not found with card_number=example_invalid")
    end
    
    it "should return 404 Not Found" do
      post "/api/categories/#{@category.id}.json", json_body_invalid_password, request_header
      jsons = JSON.parse(response.body)
      expect(jsons["detail"]).to eq("invalid password")
    end
    
    it "should return 404 Not Found" do
      post "/api/categories/#{@category.id+10}.json", json_body, request_header
      jsons = JSON.parse(response.body)
      expect(jsons["detail"]).to eq("category not found with category_id=#{@category.id+10}")
    end
  end
end
