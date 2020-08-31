class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # <<バリデーション>>
  validates :nickname, presence: true, uniqueness: { case_sensitive: true }

  validates :birth_date, presence: true

  # パスワードの英数字混在を否定
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  # 全角のひらがなor漢字を使用していないか検証
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角で入力してください' } do
    validates :first_name
    validates :last_name
  end

  # 全角のカタカナを使用していないか検証
  with_options presence: true, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/, message: 'は全角カタカナで入力してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  # <<アソシエーション>>
  has_many :items
  has_many :item_transactions
end
