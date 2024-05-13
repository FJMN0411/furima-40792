class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :content, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates_format_of :price, with: /\A[0-9]+\z/, message: 'は半角数値のみ入力してください'
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :cost_id, presence: true
  alidates :date_id, presence: true
end
