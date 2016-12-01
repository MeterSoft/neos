class PromoteCode < ActiveRecord::Base

  def apply(price)
    if ratio
      price - (price.to_f * value.to_f / 100.0)
    else
      value > price ? 0.0 : price - value.to_f
    end
  end
end
