class AddWikipedia < ActiveRecord::Migration
  def change
    create_table :wikipedia_articles do |t|
      t.column :title, :string
    end
    create_table :wikipedia_posts do |t|
      t.references :wikipedia_article, :null => false 
      t.references :post, :null => false 
    end
  end
end
