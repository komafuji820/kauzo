class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  
  validates :nickname, presence: true, length: { maximum: 10 }

  # パスワードの指定。英数混合
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, on: create

  
  def self.search(search)
    if search != ""
      User.where('nickname LIKE(?)', "%#{search}%").or User.where('email LIKE(?)', "%#{search}%")
    end
  end

end
