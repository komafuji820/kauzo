class ItemCategory
  include ActiveModel::Model

  attr_accessor :image, :memo, :group_id, :name

  validates :group_id, presence: true
  validates :name, presence: true
  # image添付またはmemoの入力を必須とするバリデーションをつける
  
  def save
    category = Category.create(name: name)
    Item.create(image: image, memo: memo, group_id: group_id, category_id: category.id)
  end

  # def self.find(params)
    # item = Item.find(params)
    # category = item.category
    # return item, category
  # end
  
end