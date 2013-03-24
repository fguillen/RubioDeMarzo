class CreateItemCategories < ActiveRecord::Migration
  def change
    create_table :item_categories do |t|
      t.references :item, :null => false
      t.references :category, :null => false

      t.timestamps
    end
  end
end
