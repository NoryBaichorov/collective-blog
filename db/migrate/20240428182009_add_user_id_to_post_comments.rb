# frozen_string_literal: true

class AddUserIdToPostComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :post_comments, :user, null: false, foreign_key: true
  end
end
