class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :null => false
      t.string :section, :null => false
      t.integer :position, :null => false

      t.timestamps
    end
  end
end
