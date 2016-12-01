class CreditcardsController < ApplicationController
  inherit_resources

  def create
    create! { finish_baskets_path }
  end

  protected

    def resource_params
      request.get? ? {} : [params.require(:creditcard).permit!]
    end
end
