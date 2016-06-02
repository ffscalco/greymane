require 'rails_helper'
RSpec.describe OmniauthCallbacksController, type: :controller do
  context "when user is successfully logged in" do
    before :each do
      @user = FactoryGirl.build(:user)
      allow(@user).to receive(:persisted?) { true }
      allow(User).to receive(:find_for_google_oauth2) { @user }
      stub_env_for_omniauth

      get :google_oauth2
    end

    subject { last_response.body }

    it "set flash success" do
      expect(flash[:success]).to be_present
    end

    it "redirect to root path" do
      expect(response).to redirect_to(root_url)
    end

    it "have a current user" do
      expect(controller.current_user).to_not be_nil
    end
  end

  context "when has error on login" do
    before :each do
      @user = FactoryGirl.build(:user)
      allow(User).to receive(:find_for_google_oauth2) { @user }
      stub_env_for_omniauth

      get :google_oauth2
    end

    subject { last_response.body }

    it "set flash error" do
      expect(flash[:error]).to be_present
    end

    it "redirect to root path" do
      expect(response).to redirect_to(root_url)
    end

    it "have no current user" do
      expect(controller.current_user).to be_nil
    end
  end
end

def stub_env_for_omniauth
  # This a Devise specific thing for functional tests. See https://github.com/plataformatec/devise/issues/closed#issue/608
  request.env["devise.mapping"] = Devise.mappings[:user]

  request.env["omniauth.auth"] = OmniAuth::AuthHash.new(
    {
      "provider" => "google_oauth2",
      "uid" => "123456789",
      "info" => {
        "name" => "John Doe",
        "email" => "john.doe@myteam.com",
        "first_name" => "John",
        "last_name" => "Doe",
        "image" => "http://www.johndoe.pro/img/John_Doe.jpg"
      },
      "credentials" => {
        "token" => "ya29.CjLzAmcuVfl3kvcl4HY1EcvmXylVl2uOlnA-nhgLAz0JhMAtmq2qILFPyBizO_gA4SJrng",
        "expires_at" => 123456789,
        "expires" => true
      },
      "extra" => {
        "id_token" => "eyJhbGciOiJSUzI1NiIsImtpZCI6IjI5YzVlMmIzYThjMTQyOWQ3MzA0M2EyQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXRfaGFzaCI6ImY3X05fZjhudXAwMTVMYmVFX2w5WlEiLCJhdWQiOiIxMDYxMDg2ODExNjkzLTI0bzI5cTNkdHE4dmFnMmJoZWxnbjlkN21lZDJwbTlvLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTEyNTE4NTAzMjkwNDg1Njk1MTQzIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF6cCI6IjEwNjEwODY4MTE2OTMtMjRvMjlxM2R0cTh2YWcyYmhlbGduOWQ3bWVkMnBtOW8uYXBwcy5nbpc2xhbS5jb20uYnIiLCJpYXQiOjE0NjQ3NDc2NDAsImV4cCI6MTQ2NDc1MTI0MH0.SuvZSEMuge5aXzA3YOb4sbxpCr-oz4TMb4galiDw5a3m7Yy4dplLeYpxGbbRzzpVvrLcKmq1Y2aiVRsxWCDrYc_TgdyPJsJ9PaN7w7iOTqNYgsXmr6kmBcPZn3PJ7XNNo804uZN7tQHeFYlSlMrEOPZeTHbXGui9ZBHq30cQa1b8-z-tLpXatGL0vKznciA0RCMTwene4TJjN_of_zbvU5lFdDuXcLP2JLKNU8TCcIAdI71ZKRzBXHEdgzGb-tSUOQoFYVD0ywOGsHgYS2ODk08loXVe1CV-wyCnn1YMTtDr6SN3j_AnzK2Rf4tRy6UoANDruPWXcXklmplOHyVrug",
        "id_info" => {
          "iss" => "accounts.google.com",
          "at_hash" => "f7_N_f4nup015LbeE_l9JD",
          "aud" => "4567med2pm9o.apps.googleusercontent.com",
          "sub" => "12345678912345678912345798",
          "email_verified" => true,
          "azp" => "123456789123-lgn9d7med2pm9o.apps.googleusercontent.com",
          "hd" => "myteam.com",
          "email" => "john.doe@myteam.com",
          "iat" => 123456789,
          "exp" => 123456789123
        },
        "raw_info" => {
          "kind" => "plus#personOpenIdConnect",
          "sub" => "987654321987645",
          "name" => "John Doe",
          "given_name" => "John",
          "family_name" => "Doe",
          "picture" => "http://www.johndoe.pro/img/John_Doe.jpg",
          "email" => "john.doe@myteam.com",
          "email_verified" => "true",
          "locale" => "en-US",
          "hd" => "myteam.com"
        }
      }
    }
  )
end
