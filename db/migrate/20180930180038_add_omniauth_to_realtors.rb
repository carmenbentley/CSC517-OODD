class AddOmniauthToRealtors < ActiveRecord::Migration[5.2]
  def change
    add_column :realtors, :provider, :string
    add_column :realtors, :uid, :string
    add_column :realtors, :oauth_token, :string
    add_column :realtors, :oauth_expires_at, :datetime
  end
end
