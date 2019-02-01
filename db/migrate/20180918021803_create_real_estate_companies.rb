# frozen_string_literal: true

# Create RealEstateCompanies Migration
class CreateRealEstateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :real_estate_companies do |t|
      t.string :name, null: false
      t.string :website, null: false
      t.string :address, null: false
      t.integer :size, null: false
      t.integer :founded, null: false
      t.decimal :revenue, null: false
      t.string :synopsis, null: false

      t.timestamps
    end
  end
end
