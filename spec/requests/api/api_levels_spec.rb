require 'spec_helper'

describe "POST /api_levels" do
  subject { page }
  before do
    @user = User.create(name: "Example User", email: "user@example.com",
                        password: "foobar", password_confirmation: "foobar",
                        card_number:"example")
    # levelを作る
    @level = Level.create(value:2, sufficiency:100)
  end
  
    # POSTの内容を作る
  describe "POST /api/levels.json" do
    # headerとbodyをつくってpathにPOST
    let(:request_header) do
      { 'CONTENT_TYPE' => 'application/json' }
    end
      
    let(:json_body) do
      '{"card_number":"example","password":"foobar"}' 
    end
    
    it "should return ok200" do
      post "/api/levels.json", json_body, request_header
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    
    # jsonの中身を調べる
    it "should return valid json data " do
      post "/api/levels.json", json_body, request_header
      jsons = JSON.parse(response.body)
      jsons.each do |json|
        if json["value"].to_i == (@level.value)
          expect(json["required_experience"].to_i).to eq(@level.sufficiency)
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
      post "/api/levels.json", json_body_invalid_user, request_header
      jsons = JSON.parse(response.body)
      expect(jsons["detail"]).to eq("user not found with card_number=example_invalid")
    end
    
    it "should return 404 Not Found" do
      post "/api/levels.json", json_body_invalid_password, request_header
      jsons = JSON.parse(response.body)
      expect(jsons["detail"]).to eq("invalid password")
    end
  end
end
