require 'spec_helper'

describe "ApiUsers" do
  describe "GET /api_users" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get api_users_index_path
      response.status.should be(200)
    end
  end
end
