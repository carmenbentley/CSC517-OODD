# frozen_string_literal: true

# Realtor model
class Realtor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :phone_number, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, length: { is: 10 }

  belongs_to :real_estate_company, optional: true
  has_many :inquiries, through: :realtor_replies_to_inquiries
  has_many :houses, dependent: :delete_all

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      password = Devise.friendly_token(8)
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.password = password
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.phone_number = '0123456789'
      AccountMailer.new_account(user.email, password, :realtor).deliver_now if user.save
    end
  end
end
