require 'test_helper'

class SubCategoriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => SubCategory.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    SubCategory.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    SubCategory.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to sub_category_url(assigns(:sub_category))
  end

  def test_edit
    get :edit, :id => SubCategory.first
    assert_template 'edit'
  end

  def test_update_invalid
    SubCategory.any_instance.stubs(:valid?).returns(false)
    put :update, :id => SubCategory.first
    assert_template 'edit'
  end

  def test_update_valid
    SubCategory.any_instance.stubs(:valid?).returns(true)
    put :update, :id => SubCategory.first
    assert_redirected_to sub_category_url(assigns(:sub_category))
  end

  def test_destroy
    sub_category = SubCategory.first
    delete :destroy, :id => sub_category
    assert_redirected_to sub_categories_url
    assert !SubCategory.exists?(sub_category.id)
  end
end
