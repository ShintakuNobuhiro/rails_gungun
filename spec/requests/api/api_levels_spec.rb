require 'spec_helper'

describe "Api::Levels" do
  describe "POST /api_levels" do
    before do
      # userを作る
      @user = @role.users.build(name: "Example User", email: "user@example.com",
                                password: "foobar", password_confirmation: "foobar",
                                card_number:"example")
      # levelを作る
      @level = Level.new(value:1, sufficiency:1)

      # POSTの内容を作る
      describe 'POST /api/levels.json' do
        # headerとbodyをつくってpathにPOST
        let(:request_header) do
          { 'CONTENT_TYPE' => 'application/json' }
        end
        
        let(:json_body) do
          {} 
        end
      # 200が返ってくることをチェック
      # jsonの中身を調べる
      end
    end
  end
end
