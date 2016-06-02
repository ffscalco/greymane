FactoryGirl.define do
  factory :user do
    team { FactoryGirl.build(:team) }
  end

end
