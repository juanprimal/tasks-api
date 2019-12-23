class User < ApplicationRecord
  has_many :user_tasks, dependent: :destroy
  validates_presence_of :name
end
