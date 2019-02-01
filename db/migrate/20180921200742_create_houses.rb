class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :location, null: false
      t.decimal :square_footage, null: false
      t.integer :year_built, null: false
      t.string :style, null: false
      t.decimal :list_price, null: false
      t.integer :num_floors, null: false
      t.boolean :basement, null: false

      t.references :real_estate_company
      t.timestamps
    end
  end
end
