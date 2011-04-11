require 'spec_helper'

describe "CallHistories" do
  describe "GET /call_histories" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get call_histories_path
      response.status.should be(200)
    end
  end
end
