class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :local
      t.decimal :price, precision: 2
      t.string :site
      t.text :subject
      t.date :start_date
      t.time :start_time
      t.date :end_date
      t.time :end_time

      t.timestamps null: false
    end
  end
end
