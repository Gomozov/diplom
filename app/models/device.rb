class Device < ActiveRecord::Base
  has_many :reports

  def self.find_or_create_by_code (code)
    first(:conditions => {:device_code => code})||create (:device_code => code) 
  end

end
