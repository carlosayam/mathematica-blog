class AddReferenceImage < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.column :image, :text
    end
  end
end
