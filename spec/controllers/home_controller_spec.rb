require 'rails_helper'
RSpec.describe HomeController, type: :controller do
  context "when user is logged in" do
    it "access index" do
      sign_in

      get :index
      expect(response.code).to eq("200")
    end
  end

  context "when user isn't logged in" do
    it "access index" do
      get :index
      expect(response.code).to eq("200")
    end
  end
end
