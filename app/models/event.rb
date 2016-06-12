class Event < ActiveRecord::Base
  belongs_to :team

  validates :name, :local, :subject, :start_date, :end_date, :team, presence: true

  scope :from_team, ->(team_id) { where(team_id: team_id) }
end
