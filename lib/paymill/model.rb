module Paymill
  module Naming
    def api_path(id = nil)
      [pluralized_name, id].compact.join('/')
    end
    
    def pluralized_name
      name.split("::").last.downcase + 's'
    end
  end
  
  class Model
    extend Paymill::Naming
    extend Paymill::Operations::All
    extend Paymill::Operations::Create
    extend Paymill::Operations::Find

    def initialize(attributes = {})
      attributes.each_pair do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
