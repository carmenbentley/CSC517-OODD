class CreateInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries do |t|
      t.string :subject
      t.string :message
      t.references :house
      t.references :hunter

      t.timestamps
    end
  end
end
