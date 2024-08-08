require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品が出品できるとき' do
      it '全ての条件が揃っていれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が出品できないとき' do
      it '商品画像を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end

      it '商品名が必須であること' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Product name can't be blank"
      end

      it '商品の説明が必須であること' do
        @item.product_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Product description can't be blank"
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end

      it '商品の状態の情報が必須であること' do
        @item.product_condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Product condition can't be blank"
      end

      it '配送料の負担の情報が必須であること' do
        @item.shipping_fee_burden_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping fee burden can't be blank"
      end

      it '発送元の地域の情報が必須であること' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end

      it '発送までの日数の情報が必須であること' do
        @item.shipping_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping day can't be blank"
      end

      it '価格の情報が必須であること' do
        @item.selling_price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Selling price can't be blank"
      end

      it '価格は、¥300~¥9,999,999の間のみ保存可能であること' do
        @item.selling_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include 'Selling price must be greater than or equal to 300'

        @item.selling_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include 'Selling price must be less than or equal to 9999999'
      end

      it '価格は半角数値のみ保存可能であること' do
        @item.selling_price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Selling price is not a number'
      end

      it 'カテゴリーが選択されていないと商品が出品できないこと' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end

      it '商品の状態が選択されていないと商品が出品できないこと' do
        @item.product_condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Product condition can't be blank"
      end

      it '配送料の負担が選択されていないと商品が出品できないこと' do
        @item.shipping_fee_burden_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping fee burden can't be blank"
      end

      it '発送元の地域が選択されていないと商品が出品できないこと' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end

      it '発送までの日数が選択されていないと商品が出品できないこと' do
        @item.shipping_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping day can't be blank"
      end

      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
