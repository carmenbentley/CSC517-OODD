class UpdateHouse < ActiveRecord::Migration[5.2]
  def change
    change_table :houses do |t|
      t.references :realtor
      t.string :owner
    end

    create_table :houses_hunters, id: false do |t|
      t.belongs_to :house, index: true
      t.belongs_to :hunter, index: true
      t.timestamps
    end
  end
end
