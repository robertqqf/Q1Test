class TestDb < ActiveRecord::Base
  validates :city_code, :uniqueness => { :scope => [:cs] }
  belongs_to :user
end
