class User < ApplicationRecord
  #remember_token、activation_token、reset_tokenというインスタンスをuserモデルに持たせる
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: {maximum: 15}
  VALID_EMAIL_REGEX = /[A-Za-z0-9._+]+@[A-Za-z]+.[A-Za-z]/ 
  validates :email, presence: true, uniqueness:{case_sensitive: false}, format: {with: VALID_EMAIL_REGEX }
  has_secure_password
  VALID_PASWAD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}\z/i
  validates :password, presence: true, length: {in: 8..32}, format: {with: VALID_PASWAD_REGEX}, allow_nil: true
    
  has_many :plans, dependent: :destroy
  has_many :plan_destinations, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :record_destinations, dependent: :destroy
  has_many :plan_favorites, dependent: :destroy
  has_many :destination_favorites, dependent: :destroy
  has_many :favorite_destinations, through: :destination_favorites, source: 'plan_destination'
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id",dependent: :destroy
  
  #フォローした相手がたくさんいる
  has_many :following, through: :active_relationships, source: :followed
  #フォローした側がたくさんいる
  has_many :followers, through: :passive_relationships, source: :follower
  
  mount_uploader :image, ImageUploader
  
  
  #渡された文字列のハッシュを返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  #記憶トークンを作成する
  #トークンはA–Z、a–z、0–9、"-"、"_"のいずれかの文字 (64種類) からなる長さ22のランダムな文字列を返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  #トークンを作成し、remember_tokenに代入する
  #remember_tokenをハッシュに変換し、remenber_digestを更新する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  #暗号化されたもの(digest)と暗号化される前のもの(token)が一致しているかを確認
  #attributeは変数
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  #アカウントを有効化する
  def activate
    update_columns(activated: FILL_IN, activated_at: FILL_IN)
  end
  
  #有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  #パスワード再設定の属性を追加する
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: FILL_IN, reset_sent_at: FILL_IN)
  end
  
  #パスワード再設定用のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  #パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  #ユーザーをフォローする
  #<<演算子 (Shovel Operator) で配列の最後に追記する
  def follow(other_user)
    following << other_user
  end
  
  #ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  #現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  
  private
  
  #メールアドレスを小文字にする
  def downcase_email
    self.email = email.downcase
  end
  
  #有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
  
  
end
