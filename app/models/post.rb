class Post < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy

  validates :title, length:{maximum:20}
  validates :body, length:{maximum:200}

  has_many_attached :images

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
