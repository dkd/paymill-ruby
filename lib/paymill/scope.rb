module Paymill
  class Scope
    include Enumerable
    
    def initialize(resource)
      @resource = resource
      @scope = { order: 'created_at_asc' }
      reset_cache
    end
    
    # chainable methods
    
    def where(values)
      @scope.merge!(values)
      reset_cache
    end

    def order(name, direction=:asc)
      @scope[:order] = "#{name}_#{direction}"
      reset_cache
    end
    
    def reverse_order
      o = @scope[:order].rpartition('_')
      order(o.first, o.last=='asc' ? :desc : :asc)
    end
        
    def limit(value)
      @scope[:count] = value
      reset_cache
    end
    
    def offset(value)
      @scope[:offset] = value
      reset_cache
    end
    
    def paginate(page=1, per_page=20)
      limit(per_page).offset(per_page*(page-1))
    end

    # trigger methods
    
    def each(&block)
      _find_and_initialize.each(&block)
    end
    
    def all
      to_a
    end
    
    def last(*count) 
      @cached ? to_a.last(*count) : reverse_order.first(*count)
    end
    
    def first(*count)
      @cached ? to_a.first(*count) : limit(count.first||1).to_a.first(*count)
    end
    
    def delete_all
      each(&:delete)
    end

    def total
      _find['data_count'].to_i
    end
    
    def empty?
      !any?
    end
    
    private
    
    def _find
      @cached ||= Paymill.request(:get, @resource.api_path, @scope.sort)
    end
    
    def _find_and_initialize
      @cached_items ||= _find['data'].map { |d| @resource.new(d) }
    end
    
    def reset_cache
      @cached = @cached_items = nil
      self
    end
  end
end