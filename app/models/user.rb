class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.find_for_google_oauth2(access_token)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    return user if user

    registered_user = User.where(:email => access_token.info.email).first
    return registered_user if registered_user

    user = User.create(
      name: data["name"],
      provider:access_token.provider,
      email: data["email"],
      uid: access_token.uid ,
      password: Devise.friendly_token[0,20]
    )
  end
end
