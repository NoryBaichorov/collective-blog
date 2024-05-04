# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  body        :text
#  category_id :integer          not null
#  creator_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: 'User', inverse_of: :posts

  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy

  validates :title, presence: true, length: { minimum: 5, maximum: 255 }
  validates :body, presence: true, length: { minimum: 200, maximum: 4000 }

  scope :ordered_posts_with_creator, -> { includes(:creator).order(created_at: :desc) }
end
