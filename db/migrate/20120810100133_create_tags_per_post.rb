class CreateTagsPerPost < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.column :text, :string
      t.column :posts_counter, :integer
    end
    create_table :tags_posts do |t|
      t.references :tag, :null => false 
      t.references :post, :null => false 
    end
  end
end
