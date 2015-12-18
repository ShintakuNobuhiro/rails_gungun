require 'spec_helper'

describe "POST /api/users/:card_number" do
  subject { page }
  before do
    @category = Category.create(name: "健康")
    @category2 = Category.create(name: "お友達・あいさつ")
    @level1 = Level.create(value:1, sufficiency:0)
    @level = Level.create(value:2, sufficiency:50)
    @level3 = Level.create(value:3, sufficiency:100)
    @role = Role.create(name:"student")
    @user = User.create(name: "Example User", email: "user@example.com",
                        password: "foobar", password_confirmation: "foobar",
                        card_number:"example", role_id: @role.id)
    @mission = Mission.create(level_id: @level.id, category_id: @category.id, description:"説明文")
    @mission2 = Mission.create(level_id: @level.id, category_id: @category2.id, description:"説明文2")
    @assign = Assign.create(mission_id: @mission.id, user_id: @user.id, achievement: true)
    @assign2 = Assign.create(mission_id: @mission2.id, user_id: @user.id, achievement: true)
  end
  
  describe "POST /api/users/:card_number.json" do
    let(:request_header) do
      { 'CONTENT_TYPE' => 'application/json' }
    end
    
    let(:json_body) do
      '{"password":"foobar"}' 
    end
    
    it "should return ok200" do
      post "/api/users/#{@user.card_number}.json", json_body, request_header
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    
    it "should return valid json data" do
      post "/api/users/#{@user.card_number}.json", json_body, request_header
      json = JSON.parse(response.body)
      expect(json["role"]).to eq(@role.name)
      expect(json["nick_name"]).to eq(@user.name)
      expect(json["recent_cell"].to_i).to eq(@user.recent_cell)
      expect(json["cell"].to_i).to eq(@user.cell)
      statuses = json["statuses"]
      statuses.each do |status|
       if status["category"] == (@category.name)
          expect(status["level"].to_i).to eq 1
          expect(status["recent_experience"].to_i).to eq 0
          expect(status["experience"].to_i).to eq 0
          expect(status["next_level_required_experience"].to_i).to eq 50
        end
      end
      assigns = json["assigns"]
      assigns.each do |assign|
        if assign["mission_id"] == (@mission.id)
          expect(assign["category"]).to eq(@category.name)
          expect(assign["level"].to_i).to eq(@level.value)
          expect(assign["description"]).to eq(@mission.description)
          expect(assign["achievement"]).to eq(@assign.achievement)
        end
      end
    end
    
    let(:json_body_invalid_password) do
      '{"password":"foobar_invalid"}' 
    end
    
    it "should return 404 Not Found user not found" do
      post "/api/users/#{@user.card_number+"invalid"}.json", json_body, request_header
      json = JSON.parse(response.body)
      expect(json["detail"]).to eq("user not found with card_number=#{@user.card_number+"invalid"}")
    end
    
    it "should return 404 Not Found invalid password" do
      post "/api/users/#{@user.card_number}.json", json_body_invalid_password, request_header
      json = JSON.parse(response.body)
      expect(json["detail"]).to eq("invalid password")
    end
  end
end
