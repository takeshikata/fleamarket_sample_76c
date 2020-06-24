class Profile < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user

  #validates_associated :user
  validates :first_name, :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/,
    message: "全角で入力してください" }
  validates :first_name_kana, :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/,
    message: "全角カナで入力してください" }
  validates :birth_date, presence: true
end
