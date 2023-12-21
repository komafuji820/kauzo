class Item < ApplicationRecord
  belongs_to :group
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :priority

end
