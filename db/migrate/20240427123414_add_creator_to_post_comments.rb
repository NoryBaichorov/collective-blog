# frozen_string_literal: true

class AddCreatorToPostComments < ActiveRecord::Migration[7.1]
  def change
    add_column :post_comments, :creator, :string
  end
end
