# frozen_string_literal: true

class AddReplyToInquiriesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :inquiries, :reply, :string
    add_reference :inquiries, :realtor, index: true
  end
end
