class Hash
  def flatten_keys(newhash={}, keys=nil)
    self.each do |k, v|
      k = k.to_s
      keys2 = keys ? keys+"[#{k}]" : k
      if v.is_a?(Hash)
        v.flatten_keys(newhash, keys2)
      else
        newhash[keys2] = v
      end
    end
    newhash
  end
end

def normalize_params(params, key=nil)
  params = params.flatten_keys if params.is_a?(Hash)
  result = {}
  params.each do |k,v|
    case v
      when Hash
        result[k.to_s] = normalize_params(v)
      when Array
        v.each_with_index do |val,i|
          result["#{k.to_s}[#{i}]"] = val.to_s
        end
      else
        result[k.to_s] = v.to_s
    end
  end
  result
end

