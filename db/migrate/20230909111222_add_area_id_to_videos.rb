class AddAreaIdToVideos < ActiveRecord::Migration[6.1]
  def change
    add_reference :videos, :spot, null: false, foreign_key: true
    remove_column :videos, :area
    remove_column :videos, :spot
  end
end
