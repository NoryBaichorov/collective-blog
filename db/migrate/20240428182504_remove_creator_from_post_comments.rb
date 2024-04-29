class RemoveCreatorFromPostComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :post_comments, :creator, :string
  end
end
