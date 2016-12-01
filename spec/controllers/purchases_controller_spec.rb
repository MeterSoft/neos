require "rails_helper"

describe PurchasesController, type: :controller do
  
  describe 'buy items' do

    before(:each) do
      Item.create({ name: 'Smart Hub', price: 49.99 })
      Item.create({ name: 'Motion Sensor', price: 24.99 })
    end
    
    it 'should display all items' do
      get :index
      assigns(:purchases).should eq([Item.first, Item.last])
    end

    it 'should add item to basket' do
      @request.env['HTTP_REFERER'] = 'http://test.com'
      put :purchase, id: Item.first.id
      session[:purchases].should eq([Item.first.id])
      response.should redirect_to :back
    end

  end
end
