class PostAddDescription < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.column :description, :text
    end
  end
end
