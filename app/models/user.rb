class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :orders, dependent: :destroy

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

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_column(:remember_digest, nil)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  private

  def downcase_email
    email.downcase!
  end
end
