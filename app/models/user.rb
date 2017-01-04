class User < ActiveRecord::Base
    before_save { self.email = self.email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    validates :profile, presence: true, length: { maximum: 255 }, allow_nil: true
    validates :area, presence: true, length: { maximum: 20 }, allow_nil: true
    validates :HomePage, presence: true, length: { maximum: 100 }, allow_nil: true
    validates :birth, presence: true, allow_nil: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
