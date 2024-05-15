class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index]
  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def move_to_index
    return if user_signed_in?

    redirect_to new_user_session_path
  end

  def item_params
    params.require(:item).permit(:name, :content, :category_id, :condition_id, :cost_id, :area_id, :shipping_date_id, :price,
                                 :image).merge(user_id: current_user.id)
  end
end
