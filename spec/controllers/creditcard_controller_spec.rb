require "rails_helper"

describe CreditcardsController, type: :controller do
  
  describe 'validate creditcard' do
    
    it 'should not create creditcard' do
      lambda do
        post :create, creditcard: { first_name: '' }
        flash.now.should_not be_blank
        assigns[:creditcard].should_not be_nil
      end.should change(Creditcard, :count).by(0)    
    end

    it 'should create creditcard' do
      lambda do
        post :create, creditcard: { first_name: 'test', last_name: 'test', number: '1111111111111111', csv: '234', address: 'address', email: 'test@test.ru', month: 1, year: 2000 }
        flash.now.should_not be_blank
        assigns[:creditcard].should_not be_nil
        response.should redirect_to finish_baskets_path
      end.should change(Creditcard, :count).by(1)    
    end
  end
end
