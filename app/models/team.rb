class Team < ActiveRecord::Base
  validates :name, presence: true

  def self.get_team_by_email(email)
    domain = email.gsub(/.+@([^.]+).+/, '\1')
    Team.find_or_create_by(name: domain.humanize.capitalize)
  end
end
