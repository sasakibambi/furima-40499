require 'rails_helper'

RSpec.describe Form, type: :model do
  before do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    # @form = FactoryBot.build(:form)
    @form = FactoryBot.build(:form, user_id: user.id, item_id: item.id)
  end

  describe '購入フォーム機能' do
    context '購入ができるとき' do
      it '全ての条件が揃っていれば購入できる' do
        expect(@form).to be_valid
      end
    end

    context '購入ができないとき' do
      it '郵便番号が空では購入できない' do
        @form.post_code = ''
        @form.valid?
        expect(@form.errors.full_messages).to include "Post code can't be blank"
      end

      it '郵便番号が「3桁ハイフン4桁」の形式でなければ購入できない' do
        @form.post_code = '1234567'
        @form.valid?
        expect(@form.errors.full_messages).to include "Post code is invalid"
      end

      it '都道府県が空では購入できない' do
        @form.prefecture_id = nil
        @form.valid?
        expect(@form.errors.full_messages).to include "Prefecture can't be blank"
      end

      it '市区町村が空では購入できない' do
        @form.city_name = ''
        @form.valid?
        expect(@form.errors.full_messages).to include "City name can't be blank"
      end

      it '番地が空では購入できない' do
        @form.street_address = ''
        @form.valid?
        expect(@form.errors.full_messages).to include "Street address can't be blank"
      end

      it '電話番号が空では購入できない' do
        @form.telephone_number = ''
        @form.valid?
        expect(@form.errors.full_messages).to include "Telephone number can't be blank"
      end

      it '電話番号が9桁以下では購入できない' do
        @form.telephone_number = '123456789'
        @form.valid?
        expect(@form.errors.full_messages).to include "Telephone number is invalid"
      end

      it '電話番号が12桁以上では購入できない' do
        @form.telephone_number = '123456789012'
        @form.valid?
        expect(@form.errors.full_messages).to include "Telephone number is invalid"
      end
      
      it '電話番号に半角数字以外が含まれている場合は購入できない' do
        @form.telephone_number = '090-1234-5678'
        @form.valid?
        expect(@form.errors.full_messages).to include "Telephone number is invalid"
      end
      it '電話番号にハイフンが含まれていると保存できないこと' do
        @form.telephone_number = '090-1234-5678'
        @form.valid?
        expect(@form.errors.full_messages).to include "Telephone number is invalid"
      end


      it "tokenが空では登録できないこと" do
        @form.token = nil
        @form.valid?
        expect(@form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end