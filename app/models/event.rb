class Event < ActiveRecord::Base
  validates :name, :local, :subject, :start_date, :end_date, presence: true
end
