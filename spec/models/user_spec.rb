require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "belongs to team" do
      is_expected.to belong_to(:team)
    end

    it "require a team" do
      is_expected.to validate_presence_of(:team)
    end
  end

  describe "#find_for_google_oauth2" do
    let(:access_token) { OmniAuth::AuthHash.new(
      {
        "provider" => "google_oauth2",
        "uid" => "123456789",
        "info" => {
          "name" => "John Doe",
          "email" => "john.doe@myteam.com",
          "first_name" => "John",
          "last_name" => "Doe",
          "image" => "http://www.johndoe.pro/img/John_Doe.jpg"
        }
      })
    }

    it "return user found by provider and uid" do
      user = FactoryGirl.create(:user, provider: "google_oauth2", uid: "123456789")
      expect(User.find_for_google_oauth2(access_token)).to eq(user)
    end

    it "return user found by email" do
      user = FactoryGirl.create(:user, provider: "facebook", uid: "123456789", email: "john.doe@myteam.com")
      expect(User.find_for_google_oauth2(access_token)).to eq(user)
    end

    it "return a new user" do
      expect{User.find_for_google_oauth2(access_token)}.to change(User, :count).by(1)
    end

    it "return an user not created for some reason" do
      allow_any_instance_of(User).to receive(:valid?) { false }
      user = User.find_for_google_oauth2(access_token)

      expect(user.id).to be_nil
    end
  end
end
