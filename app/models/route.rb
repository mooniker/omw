class Route < ActiveRecord::Base
  has_many :connections
  has_many :stops, :through => :connections
end
