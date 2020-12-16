class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :overview, :category_id, :status_id, :delivery_fee_id, :area_id,
                                 :period_id, :price).merge(user_id: current_user.id)
  end
end
