class PurchaseRecordsController < ApplicationController
  before_action :set_item
  def index
    @user_purchase = UserPurchase.new
  end

  def create
    
    @user_purchase = UserPurchase.new(user_params)
      if @user_purchase.valid?
         pay_item
         @user_purchase.save
         redirect_to root_path
      else
         render action: :index
      end
  end

  private

  def user_params
    params.require(:user_purchase).permit(:hoge, :item_id, :user_id, :postal_code, :area_id, :city, :house_number, :building, :tel, :purchase_record_id).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] #PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,  #商品の値段
      card: user_params[:token], #カードトークン
      currency: 'jpy' #通過の種類（日本円）
    )
  end

end
