class AddOmniauthToHunters < ActiveRecord::Migration[5.2]
  def change
    add_column :hunters, :provider, :string
    add_column :hunters, :uid, :string
    add_column :hunters, :oauth_token, :string
    add_column :hunters, :oauth_expires_at, :datetime
  end
end
