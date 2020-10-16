class PayForm
  include ActiveModel::Model
  attr_accessor :item_id, :token, :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :user_id

  # <<バリデーション>>
  with_options presence: true do
    validates :item_id
    validates :token, presence: { message: "の入力をお願いします" }
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'を正しく入力してください' }
    validates :prefecture, numericality: { other_than: 0, message: 'を選択してください' }
    validates :city
    validates :addresses
    validates :phone_number, length: { maximum: 11, message: 'が長すぎます' }
    # 電話番号は入力フォームで制限してますが、一応つけています。
    validates :user_id
  end

  def save
    item_transaction = ItemTransaction.create(
                          item_id: item_id,
                          user_id: user_id
                        )
    Address.create(
      item_transaction_id: item_transaction.id,
      postal_code: postal_code,
      prefecture: prefecture,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number
    )
  end
end
