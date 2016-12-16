class User < ApplicationRecord
  has_secure_password

  before_save { self.first_name = first_name.strip.downcase.titleize}
  before_save { self.last_name = last_name.strip.downcase.titleize}
  before_validation { self.email = email.strip.downcase }

  validates :first_name, :last_name, presence: true, length: { in: 1..50 }
  validates :email, presence: true, length: { in: 1..75 },
            format: { with: ApplicationRecord::VALID_EMAIL },
            uniqueness: { case_sentative: false }
end
