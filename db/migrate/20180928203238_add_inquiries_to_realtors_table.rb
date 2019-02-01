class AddInquiriesToRealtorsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :realtor_replies_to_inquiries do |t|
      t.belongs_to :realtor
      t.belongs_to :inquiry

      t.timestamps
    end
  end
end
