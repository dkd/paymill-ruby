module Paymill
  module Request
    module Helpers
      def flatten_hash_keys(old_hash, new_hash = {}, keys = nil)
        old_hash.each do |key, value|
          key = key.to_s
          if value.is_a?(Hash)
            all_keys_formatted = keys + "[#{key}]"
            flatten_hash_keys(value, new_hash, all_keys_formatted)
          else
            new_hash[key] = value
          end
        end
        new_hash
      end

      def normalize_params(params, key=nil)
        params = flatten_hash_keys(params) if params.is_a?(Hash)
        result = {}
        params.each do |key, value|
          case value
          when Hash
            result[key.to_s] = normalize_params(value)
          when Array
            value.each_with_index do |item_value, index|
              result["#{key.to_s}[#{index}]"] = item_value.to_s
            end
          else
            result[key.to_s] = value.to_s
          end
        end
        result
      end
    end
  end
end
