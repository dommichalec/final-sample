class User < ApplicationRecord

  before_save { self.first_name = first_name.strip.downcase.titleize}
  before_save { self.last_name = last_name.strip.downcase.titleize}
  before_validation { self.email = email.strip.downcase }

  validates :first_name, :last_name, presence: true, length: { in: 1..50 }
  validates :email, presence: true, length: { in: 1..75 },
            format: { with: ApplicationRecord::VALID_EMAIL_REGEX },
            uniqueness: { case_sentative: false }
  validates :password, length: { minimum: 6, allow_blank: true }

  has_secure_password

  # returns a string of the user's full name
  def full_name
    "#{first_name} #{last_name}"
  end

  def archived?
    archived == true
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                   BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
