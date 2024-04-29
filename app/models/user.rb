# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable

  validates :email, uniqueness: true, presence: true

  has_many :posts, foreign_key: 'creator_id', inverse_of: :creator, dependent: :destroy
  has_many :comments, class_name: 'PostComment', dependent: :destroy
end
