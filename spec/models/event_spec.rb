require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "validations" do
    it "require a name" do
      is_expected.to validate_presence_of(:name)
    end

    it "require a local" do
      is_expected.to validate_presence_of(:local)
    end

    it "require a subject" do
      is_expected.to validate_presence_of(:subject)
    end

    it "require a start_date" do
      is_expected.to validate_presence_of(:start_date)
    end

    it "require a end_date" do
      is_expected.to validate_presence_of(:end_date)
    end
  end
end
