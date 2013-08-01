class User < ActiveRecord::Base
  has_many :records
  has_many :games, through: :records
  has_one  :subscription
  validates_presence_of :email
  # Remember to create a migration!
end
