class CreateHouseHasInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :house_has_inquiries do |t|
      t.belongs_to :house, index: true
      t.belongs_to :inquiry, index: true

      t.timestamps
    end
  end
end
