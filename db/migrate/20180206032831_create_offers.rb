class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.string :advertiser_name
      t.string :url
      t.text :description
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :premium
      t.integer :status
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
