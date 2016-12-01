require "rails_helper"

describe Creditcard, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:number) }
    it { should_not allow_value("111111111").for(:number) }
    it { should allow_value("1111111111111111").for(:number) }
    it { should validate_presence_of(:csv) }
    it { should allow_value("333").for(:csv) }
    it { should_not allow_value("33").for(:csv) }

    it { should validate_presence_of :month }
    it { should_not allow_value("test").for(:month) }
    it { should validate_presence_of :year }
    it { should_not allow_value("test").for(:year) }
    it { should allow_value("123").for(:year) }
    it { should validate_presence_of :address }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :first_name }

    it { should validate_length_of(:number).is_equal_to(16) }
    it { should validate_length_of(:csv).is_at_least(3).is_at_most(4) }
  end
end
