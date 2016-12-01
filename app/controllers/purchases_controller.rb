class PurchasesController < ApplicationController
  inherit_resources

  defaults resource_class: Item

  def purchase
    session[:purchases] ||= []
    session[:purchases] << params[:id].to_i
    redirect_to :back, notice: "Item added to basket"
  end
end
