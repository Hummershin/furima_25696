require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: user.id)
    # @item.images = fixture_file_upload('/sample.png', 'image/png')
  end
  describe '商品作成' do
    context '内容に問題ない場合' do
      it '全て正常' do
        expect(@item.valid?).to eq true
      end
    end
    context '内容に問題がある場合' do
      it 'image:必須' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it 'name:必須' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'info:必須' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品情報を入力してください")
      end
      it 'price:必須' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end
      it 'price:半角数字' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格金額は半角で入力してください")
      end
      it 'price:範囲指定' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格販売価格は300~9,999,999円の範囲で入力してください")
      end
      it 'price:範囲指定' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格販売価格は300~9,999,999円の範囲で入力してください")
      end
      it 'category_id:0以外' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end
      it 'sales_status_id:0以外' do
        @item.sales_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end
      it 'shipping_fee_status_id:0以外' do
        @item.shipping_fee_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end
      it 'prefecture_id:0以外' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end
      it 'scheduled_delivery_id:0以外' do
        @item.scheduled_delivery_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end
    end
  end
end
