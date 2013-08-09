class ClientNo < ActiveRecord::Base
  validates :c_no, :uniqueness => { :scope => [:city_code_id] }
  belongs_to :city_code
  belongs_to :user
end
