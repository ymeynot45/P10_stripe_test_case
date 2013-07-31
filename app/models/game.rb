class Game < ActiveRecord::Base
  has_many :records
  has_many :users, through: :records
  # Remember to create a migration!
end
