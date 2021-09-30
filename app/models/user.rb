class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :recipes
  has_many :menus
  has_many :shopping_lists
end
