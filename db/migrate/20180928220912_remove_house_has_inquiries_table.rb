class RemoveHouseHasInquiriesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :house_has_inquiries
  end
end
