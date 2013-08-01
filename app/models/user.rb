class User < ActiveRecord::Base
  has_many :records
  has_many :games, through: :records
  has_one  :subscription
  # Remember to create a migration!
end
