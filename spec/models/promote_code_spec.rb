require "rails_helper"

describe PromoteCode, type: :model do    

  it 'should calculate as %' do
    code = PromoteCode.create({ name: '20%OFF', value: 20, ratio: true, promo_type: :uniq })

    expect(code.apply(110)).to eq(88.0)
  end

  it 'should calculate as static' do
    static_code = PromoteCode.create({ name: '20POUNDSOFF', value: 20, ratio: false, promo_type: :all })

    expect(static_code.apply(110)).to eq(90.0)
  end
end
