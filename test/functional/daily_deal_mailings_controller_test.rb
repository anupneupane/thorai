require 'test_helper'

class DailyDealMailingsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => DailyDealMailing.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    DailyDealMailing.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    DailyDealMailing.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to daily_deal_mailing_url(assigns(:daily_deal_mailing))
  end

  def test_edit
    get :edit, :id => DailyDealMailing.first
    assert_template 'edit'
  end

  def test_update_invalid
    DailyDealMailing.any_instance.stubs(:valid?).returns(false)
    put :update, :id => DailyDealMailing.first
    assert_template 'edit'
  end

  def test_update_valid
    DailyDealMailing.any_instance.stubs(:valid?).returns(true)
    put :update, :id => DailyDealMailing.first
    assert_redirected_to daily_deal_mailing_url(assigns(:daily_deal_mailing))
  end

  def test_destroy
    daily_deal_mailing = DailyDealMailing.first
    delete :destroy, :id => daily_deal_mailing
    assert_redirected_to daily_deal_mailings_url
    assert !DailyDealMailing.exists?(daily_deal_mailing.id)
  end
end
