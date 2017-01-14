class CreateShows < ActiveRecord::Migration[5.0]
  def change
    create_table :shows do |t|
      t.string :name
      t.string :format
      t.integer :episodes
      t.decimal :rating

      t.timestamps
    end
  end
end
