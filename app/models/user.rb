class User < ActiveRecord::Base
  has_many :test_dbs
  belongs_to :city_code
  has_many :client_nos
  has_many :test_logs
end
