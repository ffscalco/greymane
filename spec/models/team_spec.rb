require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "validations" do
    it "require a name" do
      is_expected.to validate_presence_of(:name)
    end
  end

  describe "#get_team_by_email" do
    it "create a team" do
      expect {
        Team.get_team_by_email("some@email.com")
      }.to change(Team, :count).by(1)
    end

    it "the created team name is captalized" do
      Team.get_team_by_email("some@some_company_name.com")
      expect(Team.last.name).to eq("Some company name")
    end
  end
end
