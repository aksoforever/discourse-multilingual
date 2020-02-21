class Multilingual::LanguageExclusion
  KEY ||= "language_exclusion".freeze
  
  def self.all
    Multilingual::Cache.wrap(KEY) { PluginStore.get(Multilingual::PLUGIN_NAME, KEY) || {} }
  end
  
  def self.list(type)
    all[type] || []
  end
  
  def self.get(type, code)
    list(type).include?(code.to_s)
  end
    
  def self.set(code, type, enabled: enabled)
    code = code.to_s
    enabled = ActiveModel::Type::Boolean.new.cast(enabled)
    exclusions = list(type)
    
    return if enabled && exclusions.blank?
  
    if enabled
      exclusions.delete(code)
    else
      exclusions.push(code) unless (exclusions.include?(code) || code == 'en')
    end
    
    data = all
    data[type] = exclusions
    
    PluginStore.set(Multilingual::PLUGIN_NAME, KEY, data)
  end
end