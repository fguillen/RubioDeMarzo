class Category < ActiveRecord::Base
  strip_attributes

  SECTIONS = {
    :work => "work",
    :projects => "projects",
    :about => "about"
  }

  attr_protected nil

  has_many :item_categories, :dependent => :destroy
  has_many :items, :through => :item_categories

  validates :name, :presence => true, :uniqueness => true
  validates :section, :presence => true, :inclusion => { :in => SECTIONS.values }

  before_validation :initialize_position

  scope :by_position, order("position asc")
  scope :in_section, lambda { |section| where(:section => section) }

  def initialize_position
    self.position ||= Category.maximum(:position).to_i + 1
  end

  def to_param
    "#{id}-#{name.to_url}"
  end
end
