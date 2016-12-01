class Creditcard < ActiveRecord::Base
  validates :first_name, :last_name, :address, presence: true
  validates :month, :year, :number, :csv, presence: true, numericality: { only_integer: true }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, uniqueness: true
  validates_length_of :number, is: 16
  validates_length_of :csv, in: 3..4
end
