class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :cost
  belongs_to :area
  belongs_to :shipping_date
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :content, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates_format_of :price, with: /\A[0-9]+\z/, message: 'は半角数値のみ入力してください'
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :cost_id, presence: true
  validates :area_id, presence: true
  validates :shipping_date_id, presence: true

  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :cost_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :area_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_date_id, numericality: { other_than: 1, message: "can't be blank" }
end
