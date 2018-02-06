class AddForcedStatusToOffers < ActiveRecord::Migration[5.1]
  def change
    add_column :offers, :forced_status, :boolean
  end
end
