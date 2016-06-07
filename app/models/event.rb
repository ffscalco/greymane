class Event < ActiveRecord::Base
  belongs_to :team

  validates :name, :local, :subject, :start_date, :end_date, :team, presence: true
end
