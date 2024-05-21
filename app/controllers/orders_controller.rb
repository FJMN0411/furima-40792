class OrdersController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_item, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order = Order.new
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    @order_address.user_id = current_user.id
    @order_address.item_id = params[:item_id]

    @item = Item.find(params[:item_id])
    price = @item.price

    if @order_address.valid?
      pay_item(price)
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :area_id, :city, :block, :building, :phone_number).merge(
      item_id: params[:item_id], user_id: current_user.id, token: params[:token]
    )
  end

  # def set_item
  # @item = Item.find(params[:item_id])
  # end

  def pay_item(price)
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
