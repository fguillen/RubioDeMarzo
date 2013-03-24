class Item < ActiveRecord::Base
  strip_attributes
  log_book

  has_many :pics, :dependent => :destroy
  has_many :item_categories, :dependent => :destroy
  has_many :categories, :through => :item_categories

  accepts_nested_attributes_for :categories, :allow_destroy => true

  attr_protected nil

  before_validation :initialize_position

  validates :title, :presence => true, :uniqueness => true
  validates :text, :presence => true
  validates :position, :presence => true

  scope :by_position, order("position asc")

  def initialize_position
    self.position ||= Item.maximum(:position).to_i + 1
  end

  def to_param
    "#{id}-#{title.to_url}"
  end
end
