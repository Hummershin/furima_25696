class Address < ApplicationRecord
  # <<アソシエーション>>
  belongs_to :item_transaction
end
