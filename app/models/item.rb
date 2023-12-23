class Item < ApplicationRecord
  belongs_to :group
  has_one_attached :image
  belongs_to :category

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :priority

end
