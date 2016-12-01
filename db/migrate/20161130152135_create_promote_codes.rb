class CreatePromoteCodes < ActiveRecord::Migration
  def change
    create_table :promote_codes do |t|
      t.string :name
      t.float :value
      t.boolean :ratio
      t.string :promo_type

      t.timestamps
    end
  end
end
