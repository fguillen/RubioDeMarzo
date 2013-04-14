class ItemCategory < ActiveRecord::Base
  validates :item_id, :uniqueness => { :scope => [:category_id] }
  validates :category_id, :presence => true

  belongs_to :item
  belongs_to :category
end
