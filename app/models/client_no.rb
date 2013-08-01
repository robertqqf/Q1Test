class ClientNo < ActiveRecord::Base
  belongs_to :city_code
  belongs_to :user
end
