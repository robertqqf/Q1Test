class TestDb < ActiveRecord::Base
  validates :city_code, :uniqueness => { :scope => [:cs,:year,:month] }
  belongs_to :user
end
