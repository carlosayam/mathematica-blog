class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.column :year, :integer
      t.column :title, :string, :limit => 1024
      t.column :path, :string, :limit => 1024
      t.column :path_mtime, :integer
      t.timestamps
    end
  end
end
