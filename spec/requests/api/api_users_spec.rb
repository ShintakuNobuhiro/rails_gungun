require 'spec_helper'

describe "POST /api/users/:card_number" do
  subject { page }
  before do
    @user = User.create(name: "Example User", email: "user@example.com",
                        password: "foobar", password_confirmation: "foobar",
                        card_number:"example")
    @category = Category.create(name: "健康")
    @level = Level.create(value:2, sufficiency:100)
    @role = Role.create(name:"student")
    @mission1 = Mission.create(id:20, level_id: @level.id, category_id: @category.id, description:"説明文")
    @mission2 = Mission.create(id:18, level_id: @level.id, category_id: @category.id, description:"説明文")
  end
  
  describe "POST /api/users/:card_number.json" do
  end
end
