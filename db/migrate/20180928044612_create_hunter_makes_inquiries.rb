class CreateHunterMakesInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :hunter_makes_inquiries do |t|
      t.belongs_to :hunter
      t.belongs_to :inquiry

      t.timestamps
    end
  end
end
