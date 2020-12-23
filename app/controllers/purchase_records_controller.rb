class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root
  before_action :sold_out_item

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
    params.require(:user_purchase).permit(:postal_code, :area_id, :city, :house_number, :building, :tel, :purchase_record_id).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: user_params[:token], # カードトークン
      currency: 'jpy' # 通過の種類（日本円）
    )
  end

  def move_to_root
    redirect_to root_path if current_user.id == @item.user_id
  end

  def sold_out_item
    redirect_to root_path if @item.purchase_record.present?
  end
end
