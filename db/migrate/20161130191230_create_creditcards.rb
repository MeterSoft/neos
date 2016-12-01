class CreateCreditcards < ActiveRecord::Migration
  def change
    create_table :creditcards do |t|
      t.string :email
      t.string :address
      t.string :first_name
      t.string :last_name
      t.string :number
      t.string :csv
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
