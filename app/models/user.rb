class User < ApplicationRecord

  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy
  #has_one_attachedメソッド記載したモデル各レコードは、各1つのファイルを添付可能
  has_one_attached :image

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  #正規表現によって、特定の文字を弾くようにしております。
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i

  #バリデーション(モデルの機能)
  validates :name, presence: true, length: { maximum: 20 }
  validates :profile, length: { maximum: 200 }
  #validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  #validates :encrypted_password, presence: true, length: { minimum: 6 }, format: { with: VALID_PASSWORD_REGEX }
  #validates :reset_password_token, presence: true, length: { minimum: 6 }, format: { with: VALID_PASSWORD_REGEX }
  
end