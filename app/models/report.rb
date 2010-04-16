class Report < ActiveRecord::Base
  has_many :fields, :class_name => 'ReportField'
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
     convert( (@fields_cache ||= {})[key] ||= fields.find_by_key(key) )
  end

  def fields_hash
    result = Hash[fields.map{|f| [f.key, convert(f.value)]}]
    result.merge! attributes
    result
  end

  def physical_fields_hash
     result = Hash[fields.map{|f| [f.key, convert(f.value)]}]
     # result = temporary_result.select {|key, value| key.include? 'data'}
     result.delete_if {|key, value| !(key.include? 'data')}
     result.each_key {|key| result[key.gsub(' data','')] = result.delete(key)}
     result
  end

  def addr_fields_hash
    result = Hash[fields.map{|f| [f.key, convert(f.value)]}]
    result.delete_if {|key, value| !(key.include? 'addr')}
    result
  end

  private 

  def convert(value)
     case value
     when nil
       nil
     when /^\d+\.\d+$/
       value.to_f
     when /^\d+$/
       value.to_i
     else
       value
     end

  end

end
