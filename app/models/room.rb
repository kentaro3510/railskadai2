class Room < ApplicationRecord

  belongs_to :user
  has_many :reservations
  #has_one_attachedメソッド記載したモデル各レコードは、各1つのファイルを添付可能
  has_one_attached :image

  #バリデーション(モデルの機能)
  validates :name_of_hotel, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :address, presence: true
  
end