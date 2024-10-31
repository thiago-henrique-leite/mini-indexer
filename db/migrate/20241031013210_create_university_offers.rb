class CreateUniversityOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :university_offers do |t|
      t.references :course, null: false, foreign_key: true
      t.decimal :full_price
      t.integer :max_payments
      t.string :enrollment_semester

      t.timestamps
    end
  end
end
