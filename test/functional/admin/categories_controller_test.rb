require "test_helper"

class Admin::CategoriesControllerTest < ActionController::TestCase
  def setup
    setup_admin_user
  end

  def test_index
    category_1 = FactoryGirl.create(:category, :section => Category::SECTIONS[:work])
    category_2 = FactoryGirl.create(:category, :section => Category::SECTIONS[:work])
    category_3 = FactoryGirl.create(:category, :section => Category::SECTIONS[:about])

    get :index, :section => Category::SECTIONS[:work]

    assert_template "admin/categories/index"
    assert_equal([category_1, category_2].ids, assigns(:categories).ids)
  end

  def test_new
    get :new
    assert_template "admin/categories/new"
    assert_not_nil(assigns(:category))
  end

  def test_create_invalid
    Category.any_instance.stubs(:valid?).returns(false)

    post :create

    assert_template "new"
    assert_not_nil(flash[:alert])
  end

  def test_create_valid
    post(
      :create,
      :category => {
        :name => "Category Name",
        :section => Category::SECTIONS[:work]
      }
    )

    category = Category.last
    assert_redirected_to edit_admin_category_path(category)

    assert_equal("Category Name", category.name)
    assert_equal("work", category.section)
  end

  def test_edit
    category = FactoryGirl.create(:category)

    get :edit, :id => category

    assert_template "edit"
    assert_equal(category, assigns(:category))
  end

  def test_update_invalid
    category = FactoryGirl.create(:category)
    Category.any_instance.stubs(:valid?).returns(false)

    put :update, :id => category

    assert_template "edit"
    assert_not_nil(flash[:alert])
  end

  def test_update_valid
    category = FactoryGirl.create(:category, :name => "One Name", :section => Category::SECTIONS[:work])

    put(
      :update,
      :id => category,
      :category => {
        :name => "Other Name",
        :section => Category::SECTIONS[:about]
      }
    )

    category.reload

    assert_redirected_to edit_admin_category_path(category)
    assert_not_nil(flash[:notice])

    assert_equal("Other Name", category.name)
    assert_equal("about", category.section)
  end

  def test_destroy
    category = FactoryGirl.create(:category, :section => Category::SECTIONS[:work])

    delete :destroy, :id => category

    assert_redirected_to admin_categories_path(:section => "work")
    assert_not_nil(flash[:notice])

    assert !Category.exists?(category.id)
  end

  def test_reorder
    category_1 = FactoryGirl.create(:category, :position => 1)
    category_2 = FactoryGirl.create(:category, :position => 2)
    category_3 = FactoryGirl.create(:category, :position => 3)

    assert_equal([category_1, category_2, category_3].ids, Category.by_position.ids)

    post(
      :reorder,
      :ids => [category_2, category_3, category_1].ids
    )

    assert_response :success
    assert_equal("application/json", response.content_type)
    assert_equal("ok", JSON.parse(response.body)["status"])

    assert_equal([category_2, category_3, category_1].ids, Category.by_position.ids)
  end
end
