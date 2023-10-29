class AddEnglishTextToNewsLists < ActiveRecord::Migration[6.1]
  def change
    add_column :news_lists, :content_ens, :text
  end
end
