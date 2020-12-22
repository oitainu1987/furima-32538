class PurchaseRecordsController < ApplicationController
  before_action :set_item
  def index
    @user_purchase = UserPurchase.new
  end

  def create
    @user_purchase = UserPurchase.new(user_params)
    binding.pry
      if @user_purchase.valid?
         @user_purchase.save
         redirect_to root_path
      else
         render action: :index
      end
  end

  private

  def user_params
    params.require(:user_purchase).permit(:hoge, :item_id, :user_id, :postal_code, :area_id, :city, :house_number, :building, :tel, :purchase_record_id).merge(user_id: current_user.id, item_id: @item.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
