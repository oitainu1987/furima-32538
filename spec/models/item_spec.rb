require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '商品出品機能' do
      context '商品出品がうまくいくとき' do
        it '全ての項目の入力が存在すれば出品ができる' do
          expect(@item).to be_valid
        end
        it 'priceが半角数字で300〜9,999,999の値を入力で出品ができる' do
          @item.price = 5000
          expect(@item).to be_valid
        end
      end

      context '商品出品がうまくいかないとき' do
        it 'item_nameが空だと出品できない' do
          @item.item_name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Item name can't be blank")
        end
        it 'overviewが空だと出品できない' do
          @item.overview = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Overview can't be blank")
        end
        it 'category_idが1だと出品できない' do
          @item.category_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("Category must be other than 1")
        end
        it 'status_idが1だと出品できない' do
          @item.status_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("Status must be other than 1")
        end
        it 'delivery_fee_idが1だと出品できない' do
          @item.delivery_fee_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("Delivery fee must be other than 1")
        end
        it 'area_idが1だと出品できない' do
          @item.area_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("Area must be other than 1")
        end
        it 'period_idが1だと出品できない' do
          @item.period_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("Period must be other than 1")
        end
        it 'priceが空だと出品できない' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end
        it 'priceが299以下だと出品できない' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
        end
        it 'priceが10,000,000以上だと出品できない' do
          @item.price = 10000000
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
        end
        it 'imageがないと出品できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
      end
    end
  end
end