class CreateJoinTableShowGenre < ActiveRecord::Migration[5.0]
  def change
    create_table :show_genres do |t|
      t.integer :show_id
      t.integer :genre_id

      t.timestamps
    end

    add_index :show_genres, :show_id
    add_index :show_genres, :genre_id
  end
end
