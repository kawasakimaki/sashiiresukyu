class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one_attached :image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :like_lists, dependent: :destroy
  has_many :comment_lists, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :like_items, through: :like_lists, source: :item

  validates :name, presence: true, length: { maximum: 20 }

  def active_for_authentication?
    super && (is_active == true)
  end

end
