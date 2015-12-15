require 'spec_helper'

describe "POST /api/users/:card_number" do
  subject { page }
  before do
    @category = Category.create(name: "健康")
    @level = Level.create(value:2, sufficiency:20)
    @role = Role.create(name:"student")
    @user = User.create(name: "Example User", email: "user@example.com",
                        password: "foobar", password_confirmation: "foobar",
                        card_number:"example", role_id: @role.id)
    @mission = Mission.create(level_id: @level.id, category_id: @category.id, description:"説明文")
    @status = Status.create(user_id: @user.id, category_id: @category.id, experience:20, recent_experience:16)
    @assign = Assign.create(mission_id: @mission.id, user_id: @user.id, achievement: true)
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
    
    it "shoul return valid json data" do
      post "/api/users/#{@user.card_number}.json", json_body, request_header
      jsons = JSON.parse(response.body)
      puts jsons
      jsons.each do |json|
        expect(jsons["role"]).to eq(@role.name)
        expect(jsons["nick_name"]).to eq(@user.name)
        expect(jsons["recent_cell"].to_i).to eq(@user.recent_cell)
        expect(jsons["cell"].to_i).to eq(@user.cell)
        statuses = jsons["statuses"]
        statuses.each do |status|
          if status["category"] == (@category.name)
            expect(status["recent_experience"].to_i).to eq(@status.recent_experience)
          end
        end
      end
    end
  end
end
