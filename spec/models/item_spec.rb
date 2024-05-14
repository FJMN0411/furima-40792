require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '新規登録できる場合' do
      it 'nameとcontent、price,category_id、condition_id、cost_id、area_id、shipping_date_id、imageが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'contentが空では登録できない' do
        @item.content = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'category_idが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'condition_idが空では登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it 'cost_idが空では登録できない' do
        @item.cost_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Cost can't be blank")
      end
      it 'area_idが空では登録できない' do
        @item.area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Area can't be blank")
      end
      it 'shipping_date_idが空では登録できない' do
        @item.shipping_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date can't be blank")
      end
      it 'priceが299以下では登録できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it 'priceが10000000以上では登録できない' do
        @item.price = '10000001'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '全角文字を含むpriceでは登録できない' do
        @item.price = '１２３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'カテゴリーに「---」が選択されている場合は出品できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態に「---」が選択されている場合は出品できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担に「---」が選択されている場合は出品できない' do
        @item.cost_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Cost can't be blank")
      end
      it '発送元の地域に「---」が選択されている場合は出品できない' do
        @item.area_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Area can't be blank")
      end
      it '発送までの日数に「---」が選択されている場合は出品できない' do
        @item.shipping_date_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date can't be blank")
      end
      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
