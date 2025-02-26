class User < ApplicationRecord
  broadcasts_refreshes
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def admin?
    admin && Setting.instance.admin_mode?
  end
end
