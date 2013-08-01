class CityCode < ActiveRecord::Base
  has_many :users
  has_many :client_nos
end
