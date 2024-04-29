# frozen_string_literal: true

# == Schema Information
#
# Table name: post_comments
#
#  id         :integer          not null, primary key
#  content    :string
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ancestry   :string
#  user_id    :integer          not null
#
class PostComment < ApplicationRecord
  belongs_to :post
  belongs_to :user, inverse_of: :comments

  has_ancestry

  validates :content, presence: true
end
