class User < ApplicationRecord
  validates :name, presence: true,
              length: {maximum: Settings.user.name_max,
                       minimum: Settings.user.name_min}
  validates :email, presence: true,
        length: {maximum: Settings.user.email_max},
        format: {with: Settings.user.email_pattern},
        uniqueness: true
  validates :password, presence: true,
        length: {minimum: Settings.user.password_min,
                 maximum: Settings.user.password_max}

  has_secure_password

  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
