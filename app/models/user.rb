class User < ApplicationRecord
  #remember_tokenというインスタンスをuserモデルに持たせる
  attr_accessor :remember_token
  before_save{self.email = email.downcase}
  
  validates :name, presence: true, length: {maximum: 15}
  
  VALID_EMAIL_REGEX = /[A-Za-z0-9._+]+@[A-Za-z]+.[A-Za-z]/ 
  validates :email, presence: true, uniqueness:{case_sensitive: false}, format: {with: VALID_EMAIL_REGEX }
  
  has_secure_password
  VALID_PASWAD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}\z/i
  validates :password, presence: true, length: {in: 8..32}, format: {with: VALID_PASWAD_REGEX}
  
  #渡された文字列のハッシュを返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost? Bcrypt::Engine::MIN_COST :Bcrypt::Engine.cost
    Bcrypt::Password.create(string, cost: cost)
  end
  
  has_many :plans
  has_many :records
  has_many :plan_destinations
  
  #ランダムなトークンを作成する
  #def User.new_token
    #SecureRandom.urlsafe_base64
  #end
  
  #selfにトークンを追加し、remenber_digestをremenber_tokenで更新する
  #def remenber
    #self.remember_token = user.new_token
    #update_attribute(:remenber_digest, User.digest(remenber_token))
  #end
  
end
