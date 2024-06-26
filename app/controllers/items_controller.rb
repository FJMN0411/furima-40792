class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_item_owner, only: [:edit, :update]
  before_action :sold_out, only: [:edit]

  def index
    @items = Item.all.order('created_at DESC')
    @order = Order.all
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

  def show
    @order = Order.all
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def move_to_index
    return if user_signed_in?

    redirect_to new_user_session_path
  end

  def authenticate_item_owner
    return unless current_user.nil? || current_user.id != @item.user_id

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :content, :category_id, :condition_id, :cost_id, :area_id, :shipping_date_id, :price,
                                 :image).merge(user_id: current_user.id)
  end

  def sold_out
    if @item.order.present? || @item.user_id != current_user.id
      redirect_to root_path
    end
  end
end
