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
          expect(@item.errors.full_messages).to include("商品名を入力してください")
        end
        it 'overviewが空だと出品できない' do
          @item.overview = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("商品の説明を入力してください")
        end
        it 'category_idが1だと出品できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('カテゴリーは1以外の値にしてください')
        end
        it 'status_idが1だと出品できない' do
          @item.status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('商品の状態は1以外の値にしてください')
        end
        it 'delivery_fee_idが1だと出品できない' do
          @item.delivery_fee_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('配送料の負担は1以外の値にしてください')
        end
        it 'area_idが1だと出品できない' do
          @item.area_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('発送元の地域は1以外の値にしてください')
        end
        it 'period_idが1だと出品できない' do
          @item.period_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('発送までの日数は1以外の値にしてください')
        end
        it 'priceが空だと出品できない' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格を入力してください")
        end
        it 'priceが299以下だと出品できない' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格は300以上の値にしてください")
        end
        it 'priceが10,000,000以上だと出品できない' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格は9999999以下の値にしてください")
        end
        it 'priceが全角文字だと出品できない' do
          @item.price = '１０００'
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
        end
        it 'priceが半角英数字混合だと出品できない' do
          @item.price = '1000en'
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
        end
        it 'priceが半角英語だけだと出品できない' do
          @item.price = 'en'
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
        end
        it 'imageがないと出品できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("商品の画像を入力してください")
        end
      end
    end
  end
end
