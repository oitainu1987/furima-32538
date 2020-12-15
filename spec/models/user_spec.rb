require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it '全ての項目の入力が存在すれば登録ができる' do
          expect(@user).to be_valid
        end
        it 'passwordが6文字以上で英数字どちらも入力があれば登録できる' do
          @user.password = 'a34567'
          @user.password_confirmation = 'a34567'
          expect(@user).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        it 'nicknameが空だと登録できない' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
        it 'emailが空だと登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank", "Email can't be blank")
        end
        it '重複したemailが存在する場合登録できない' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken', 'Email has already been taken')
        end
        it 'passwordが空では登録できない' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it 'passwordが5文字以下であれば登録できない' do
          @user.password = 'a1234'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end
        it 'passwordが半角英数字どちらも入力がなければ登録できない' do
          @user.password = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end
        it 'passwordが存在してもpassword_confirmationが空では登録できない' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it 'first_nameが空だと登録できない' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('First name is invalid')
        end
        it 'first_nameが全角入力でなければ登録できない' do
          @user.first_name = 'taro'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name is invalid')
        end
        it 'family_nameが空だと登録できない' do
          @user.family_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('Family name is invalid')
        end
        it 'family_nameが全角入力でなければ登録できない' do
          @user.family_name = 'yamada'
          @user.valid?
          expect(@user.errors.full_messages).to include('Family name is invalid')
        end
        it 'first_name_kanaが空だと登録できない' do
          @user.first_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana is invalid')
        end
        it 'first_name_kanaが全角カタカナ入力でなければ登録できない' do
          @user.first_name_kana = 'たろう'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana is invalid')
        end
        it 'family_name_kanaが空だと登録できない' do
          @user.family_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('Family name kana is invalid')
        end
        it 'family_name_kanaが全角カタカナ入力でなければ登録できない' do
          @user.family_name_kana = 'やまだ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Family name kana is invalid')
        end
      end
    end
  end
end
