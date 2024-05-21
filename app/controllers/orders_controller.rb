class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :set_gon, only: [:index, :create]
  before_action :sold_out, only: [:index, :create]

  def index
    @order = Order.new
    @order_address = OrderAddress.new
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    @order_address.user_id = current_user.id
    @order_address.item_id = params[:item_id]

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

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_gon
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def pay_item(price)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def sold_out
    return unless @item.order.present? || @item.user_id == current_user.id

    redirect_to root_path
  end
end
