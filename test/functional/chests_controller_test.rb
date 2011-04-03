require 'test_helper'

class ChestsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Chest.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Chest.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Chest.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to chest_url(assigns(:chest))
  end

  def test_edit
    get :edit, :id => Chest.first
    assert_template 'edit'
  end

  def test_update_invalid
    Chest.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Chest.first
    assert_template 'edit'
  end

  def test_update_valid
    Chest.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Chest.first
    assert_redirected_to chest_url(assigns(:chest))
  end

  def test_destroy
    chest = Chest.first
    delete :destroy, :id => chest
    assert_redirected_to chests_url
    assert !Chest.exists?(chest.id)
  end
end
