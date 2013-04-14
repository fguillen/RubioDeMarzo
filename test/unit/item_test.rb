require "test_helper"

class ItemTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert FactoryGirl.create(:item).valid?
  end

  def test_on_create_initialize_position
    item_1 = FactoryGirl.create(:item, :position => 100)
    item_2 = FactoryGirl.create(:item)

    assert_equal(101, item_2.position)
  end

  def test_scope_by_position
    item_1 = FactoryGirl.create(:item, :position => 10)
    item_2 = FactoryGirl.create(:item, :position => 9)

    assert_equal([item_2, item_1].ids, Item.by_position.ids)
  end

  def test_create_with_categories
    category = FactoryGirl.create(:category)

    item =
      Item.create!(
        :title => "Title",
        :text => "Text",
        :category_ids => [category.id]
      )

    item.reload
    assert_equal(1, item.categories.count)
    assert_equal(category, item.categories.first)
  end
end
