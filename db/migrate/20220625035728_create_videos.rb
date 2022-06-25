class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :area, null: false
      t.string :spot, null: false
      t.string :video_id, null: false, unique: true
      t.string :title, null: false
      t.string :thumbnail, null: false
      t.datetime :published_at, null: false
      t.integer :view_count, null: false

      t.timestamps
    end
  end
end
