class User < ApplicationRecord

  before_validation { self.first_name = first_name.strip.downcase.titleize}
  before_validation { self.last_name = last_name.strip.downcase.titleize}
  before_validation { self.email = email.strip.downcase }

  validates :first_name, :last_name, presence: true, length: { in: 1..50 }
  validates :email, presence: true, length: { in: 1..75 },
            format: { with: ApplicationRecord::VALID_EMAIL_REGEX },
            uniqueness: { case_sentative: false }
  validates :password, :password_confirmation, presence: true,
            length: { minimum: 6 }

  has_secure_password
end
