require 'rails_helper'

RSpec.describe UserPurchase, type: :model do
  describe '#create' do
    describe '商品購入情報の保存' do
      before do
        @user_purchase = FactoryBot.build(:user_purchase)
      end

      it '全ての値が正しく入力されていれば保存できること' do
        expect(@user_purchase).to be_valid
      end
      it 'buildingが空でも保存出来ること' do
        @user_purchase.building = ""
        expect(@user_purchase).to be_valid
      end
      it 'postal_codeが空では保存できないこと' do
        @user_purchase.postal_code = ""
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid")
      end
      it 'area_idが1だと保存できないこと' do
        @user_purchase.area_id = 1
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Area must be other than 1")
      end
      it 'cityが空だと保存できないこと' do
        @user_purchase.city = ""
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと保存できないこと' do
        @user_purchase.house_number = ""
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("House number can't be blank")
      end
      it 'telが空だと保存できないこと' do
        @user_purchase.tel = ""
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Tel can't be blank", "Tel is invalid")
      end
      it 'tokenが空だと保存できないこと' do
        @user_purchase.token = ""
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeにはハイフンがないと保存できないこと' do
        @user_purchase.postal_code = "2233344"
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Postal code is invalid")
      end
      it 'telは１０桁以下では保存できないこと' do
        @user_purchase.tel = "0900001111"
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Tel is invalid")
      end
      it 'telはハイフンを入れると保存できないこと' do
        @user_purchase.tel = "090-0001111"
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Tel is invalid")
      end
    end
  end
end
