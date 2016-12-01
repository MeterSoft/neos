class BasketsController < ApplicationController

  before_filter :get_items, only: [:index, :finish]

  def index
  end

  def attach_promo_code
    session[:promocodes] ||= []
    code = PromoteCode.find_by({ name: params[:promocode][:name] })
    @promocodes = PromoteCode.where(id: session[:promocodes])
    if !code
      redirect_to :back, flash: { error: 'Promocode not find' }
    elsif session[:promocodes].include?(code.id)
      redirect_to :back, flash: { error: 'Promocode already applayed' }
    elsif @promocodes.map(&:promo_type).include?("uniq") || (@promocodes.any? && code.promo_type == "uniq")
      redirect_to :back, flash: { error: 'Promocode can not be applayed' }
    else
      session[:promocodes] << code.id
      redirect_to :back, flash: { error: 'Successfully applayed promocode' }
    end
  end

  def remove_promo_code
    session[:promocodes].delete(params[:id].to_i)
    redirect_to :back
  end

  def update
    session[:purchases].delete(params[:id].to_i)
    redirect_to :back
  end

  def destroy
    session[:purchases] = nil
    session[:promocodes] = nil
    redirect_to root_path
  end

  def finish
    @creditcard = Creditcard.last
  end

  private

    def get_items
      items = Item.where(id: session[:purchases])
      @promocodes = PromoteCode.where(id: session[:promocodes])
      @total = 0
      @items = items.map do |item|
        count = session[:purchases].count(item.id)
        amount = item.price * count
        @total+= amount

        { id: item.id, name: item.name, price: item.price, count: count, amount: amount }
      end
      @promocodes.map { |code| @total = code.apply(@total)  } if @promocodes.any?
    end
end
