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
require "test_helper"

class PostCommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
