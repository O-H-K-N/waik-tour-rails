class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string :name, null: false, unique: true
      t.string :name_ens, null: false, unique: true
      t.string :iso, null: false, unique: true

      t.timestamps
    end
  end
end
