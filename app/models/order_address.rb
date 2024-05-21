class OrderAddress
  include ActiveModel::Model
  extend ActiveHash::Associations::ActiveRecordExtensions
  attr_accessor :postal_code, :area_id, :city, :block, :building, :phone_number, :order_id, :user_id, :item_id, :token

  validates :postal_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :area_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :city, presence: true
  validates :block, presence: true
  validates :phone_number, presence: true, format: { with: /\A[0-9]{10,11}\z/i, message: 'is invalid' }
  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :token, presence: true

  def save
    Order.transaction do
      order = Order.create(item_id:, user_id:)

      Address.create(postal_code:, area_id:, city:,
                     block:, building:, phone_number:, order_id: order.id)
    end
  end
end
