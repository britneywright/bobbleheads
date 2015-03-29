class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date
      t.string :team_name
      t.string :opponent
      t.string :promotion

      t.timestamps null: false
    end
  end
end
