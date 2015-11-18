class Connection < ActiveRecord::Base
  has_many :routes
  has_many :stops
end
