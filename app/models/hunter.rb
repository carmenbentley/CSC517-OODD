# frozen_string_literal: true

class Hunter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :phone, :preferred, presence: true
  validates :phone, length: { is: 10 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :inquiries, through: :hunter_makes_inquiries
  has_and_belongs_to_many :houses

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      password = Devise.friendly_token(8)
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.password = password
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.phone = '0123456789'
      user.preferred = 0
      AccountMailer.new_account(user.email, password, :house_hunter).deliver_now if user.save
    end
  end
end
