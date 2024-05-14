class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to items_path, notice: 'item was successfully created.'
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :content, :category_id, :condition_id, :cost_id, :area_id, :shipping_date_id, :price)
  end
end
