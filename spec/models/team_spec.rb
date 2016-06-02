require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "validations" do
    it "require a name" do
      is_expected.to validate_presence_of(:name)
    end
  end

  describe "#get_team_by_email" do
    context "when a team doesn't exist" do
      it "create a team" do
        expect {
          Team.get_team_by_email("some@fake_email.com")
        }.to change(Team, :count).by(1)
      end

      it "the created team name is captalized" do
        Team.get_team_by_email("some@some_company_name.com")
        expect(Team.last.name).to eq("Some company name")
      end
    end

    context "when a team already exist" do
      before :all do
        @team = Team.create(name: "Email", created_at: Date.today-1.day)
      end

      it "not create a team" do
        expect {
          Team.get_team_by_email("some@email.com")
        }.to change(Team, :count).by(0)
      end

      it "return a team already created" do
        team = Team.get_team_by_email("some@email.com")

        expect(team.created_at).to eq(@team.created_at)
      end
    end
  end
end
