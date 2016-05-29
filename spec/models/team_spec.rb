require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "validations" do
    it "require an name" do
      is_expected.to validate_presence_of(:name)
    end
  end
end
