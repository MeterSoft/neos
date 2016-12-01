require "rails_helper"

describe BasketsController, type: :controller do
  
  describe 'buy items' do

    before(:each) do
      Item.create({ name: 'Smart Hub', price: 20.00 })
      Item.create({ name: 'Motion Sensor', price: 30.00 })
      PromoteCode.create({ name: '20%OFF', value: 20, ratio: true, promo_type: :uniq })
      PromoteCode.create({ name: '5%OFF', value: 5, ratio: true, promo_type: :all })
      PromoteCode.create({ name: '20POUNDSOFF', value: 20, ratio: false, promo_type: :all })
      Creditcard.create({ first_name: 'test', last_name: 'test', number: '1111111111111111', csv: '234', address: 'address', email: 'test@test.ru', month: 1, year: 2000 })
    end
    
    it 'should display all items in busket without promocode' do
      item1 = Item.first
      item2 = Item.last
      session[:purchases] = [item1.id, item2.id, item2.id]
      get :index
      assigns(:items).should_not be_nil
      assigns(:promocodes).should_not be_nil
      assigns(:total).should_not be_nil
      assigns(:items).should eq([{ id: item1.id, name: item1.name, price: item1.price, count: 1, amount: item1.price }, { id: item2.id, name: item2.name, price: item2.price, count: 2, amount: item2.price * 2 }])
      assigns(:total).should eq(item1.price + item2.price * 2)
    end

    it 'should display all items in busket with promocode' do
      item1 = Item.first
      item2 = Item.last
      session[:purchases] = [item1.id]
      session[:promocodes] = [PromoteCode.last.id]
      get :index
      assigns(:items).should_not be_nil
      assigns(:promocodes).should_not be_nil
      assigns(:items).should eq([{ id: item1.id, name: item1.name, price: item1.price, count: 1, amount: item1.price }])
      assigns(:total).should eq(0)
    end

    it 'should render finish' do
      item1 = Item.first
      item2 = Item.last
      session[:purchases] = [item1.id]
      session[:promocodes] = [PromoteCode.last.id]
      get :finish
      assigns(:creditcard).should_not be_nil
      assigns(:items).should_not be_nil
      assigns(:total).should_not be_nil
      assigns(:promocodes).should_not be_nil
      assigns(:total).should_not be_nil
    end

    it 'should finish purchases' do
      item1 = Item.first
      item2 = Item.last
      session[:purchases] = [item1.id]
      session[:promocodes] = [PromoteCode.last.id]
      delete :destroy, id: 0
      session[:purchases].should be_nil
      session[:promocodes].should be_nil
    end

    it 'should remove item from basket' do
      @request.env['HTTP_REFERER'] = 'http://test.com'
      item1 = Item.first
      item2 = Item.last
      session[:purchases] = [item1.id, item2.id]
      put :update, id: item1.id
      session[:purchases].should eq([item2.id])
      response.should redirect_to :back
    end

    it 'should remove promocode' do
      @request.env['HTTP_REFERER'] = 'http://test.com'
      item1 = Item.first
      item2 = Item.last
      session[:promocodes] = [PromoteCode.last.id]
      put :remove_promo_code, id: PromoteCode.last.id
      session[:promocodes].should eq([])
      response.should redirect_to :back
    end

    it 'should add promocode' do
      @request.env['HTTP_REFERER'] = 'http://test.com'
      item1 = Item.first
      item2 = Item.last
      put :attach_promo_code, promocode: { name: PromoteCode.last.name }
      session[:promocodes].should eq([PromoteCode.last.id])
      response.should redirect_to :back
    end

  end
end
