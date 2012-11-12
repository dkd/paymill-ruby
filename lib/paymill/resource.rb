module Paymill
  class Resource
    extend Concerns::Naming
    extend Concerns::Crud
    extend SingleForwardable
    # #def_delegators :scoped, :where, :order, :limit, :offset, :each, :all, :first, :last, :count
    delegate [:where, :order, :limit, :offset, :paginate, :each, :all, :first, :last, :count, :delete_all] => :scoped
    
    def self.scoped
      Paymill::Scope.new(self)
    end
    
    include Concerns::Attributes
    include Concerns::Persistence
    
    attr_reader :id, :created_at, :updated_at
  end
end