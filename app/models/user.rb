class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :omniauthable, :omniauth_providers => [:google_oauth2]

  belongs_to :team
  validates :team, presence: true

  def self.find_for_google_oauth2(access_token)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    return user unless user.nil?

    registered_user = User.where(:email => data["email"]).first
    return registered_user unless registered_user.nil?

    team = Team.get_team_by_email(data["email"])

    User.create(
      name: data["name"],
      provider: access_token.provider,
      email: data["email"],
      uid: access_token.uid ,
      image: data["image"],
      password: Devise.friendly_token[0,20],
      team_id: team.id
    )
  end
end
