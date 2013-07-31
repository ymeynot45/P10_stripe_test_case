class User < ActiveRecord::Base
  has_many :records
  has_many :games, through: :records
  # Remember to create a migration!
end
