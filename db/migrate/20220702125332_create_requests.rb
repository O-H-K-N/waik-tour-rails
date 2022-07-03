class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true
      t.string :area, null: false
      t.string :spot, null: false
      t.integer :check, default: 0

      t.timestamps
    end
  end
end
