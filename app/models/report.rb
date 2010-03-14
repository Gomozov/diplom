class Report < ActiveRecord::Base
  has_many :report_fields
  belongs_to :devices

  def initialize(attrs)
    @raw_fields = attrs.except :device_id
    @fields_cache = {}
    super :device_id => attrs[:device_id]
  end

  def after_create
    a = @raw_fields.map do |key, value|
      field = ReportField.create :report_id =>id, :key => key.to_s, :value => value.to_s
      [ key.to_s, field]
    end
    @fields_cache = Hash[a]
  end

  def [](key)
     key = key.to_s
     attributes[key] || ( (f = field key) && f.value) || nil
  end
   
  def field(key)
     key = key.to_s
     @fields_cache[key] ||= fields.find_by_key key
  end           

end
