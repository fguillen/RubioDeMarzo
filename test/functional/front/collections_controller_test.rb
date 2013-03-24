require "test_helper"

class Front::CategoriesControllerTest < ActionController::TestCase
  def test_show
    category = FactoryGirl.create(:category)
    item = FactoryGirl.create(:item)
    item.categories << category

    get :show, :id => category

    assert :success
    assert_template "front/categories/show"
    assert_equal(category, assigns(:category))
  end
end
