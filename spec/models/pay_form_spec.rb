require 'rails_helper'

RSpec.describe PayForm, type: :model do
  before do
    buyer = FactoryBot.create(:user)
    seller = FactoryBot.create(:user)
    item = FactoryBot.build(:item, user_id: seller.id)
    # item.image = fixture_file_upload('/sample.png', 'image/png')
    item.save
    @pay_form = FactoryBot.build(:pay_form, user_id: buyer.id, item_id: item.id)
    sleep 1
  end
  describe '商品購入' do
    context '内容に問題ない場合' do
      it '全て正常' do
        expect(@pay_form.valid?).to eq true
      end
    end
    context '内容に問題がある場合' do
      it 'token:必須' do
        @pay_form.token = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("カード情報の入力をお願いします")
      end
      it 'postal_code:必須' do
        @pay_form.postal_code = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("郵便番号を入力してください", "郵便番号を正しく入力してください")
      end
      it 'postal_code:フォーマット' do
        @pay_form.postal_code = '1234567'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("郵便番号を正しく入力してください")
      end
      it 'prefecture:必須' do
        @pay_form.prefecture = nil
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("都道府県を入力してください")
      end
      it 'prefecture:0以外' do
        @pay_form.prefecture = 0
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("都道府県を選択してください")
      end
      it 'city:必須' do
        @pay_form.city = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'addresses:必須' do
        @pay_form.addresses = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_number:必須' do
        @pay_form.phone_number = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_number:11桁以内' do
        @pay_form.phone_number = '1234567891011'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("電話番号が長すぎます")
      end
    end
  end
end
