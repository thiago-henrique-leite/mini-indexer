class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.references :university_offer, null: false, foreign_key: true
      t.decimal :discount_percentage
      t.boolean :enabled

      t.timestamps
    end
  end
end
