class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.references :country, foreign_key: true
      t.string :name, null: false, unique: true
      t.string :name_ens, null: false, unique: true
      t.decimal :lat,  precision: 11, scale: 8, null: false
      t.decimal :lng, precision: 11, scale: 8, null: false

      t.timestamps
    end
  end
end
