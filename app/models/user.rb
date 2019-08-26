class User < ApplicationRecord
  before_save{self.email = email.downcase}
  
  validates :name, presence: true, length: {maximum: 15}
  
  VALID_EMAIL_REGEX = /[A-Za-z0-9._+]+@[A-Za-z]+.[A-Za-z]/ 
  validates :email, presence: true, uniqueness:{case_sensitive: false}, format: {with: VALID_EMAIL_REGEX }
  
  has_secure_password
  VALID_PASWAD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}\z/i
  validates :password, presence: true, length: {in: 8..32}, format: {with: VALID_PASWAD_REGEX}
  
end
