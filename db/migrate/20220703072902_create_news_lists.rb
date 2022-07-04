class CreateNewsLists < ActiveRecord::Migration[6.1]
  def change
    create_table :news_lists do |t|
      t.text :content, null: false

      t.timestamps
    end
  end
end
