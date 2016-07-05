class AddTeamToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :team, index: true, foreign_key: true
  end
end
