module Paymill
  class Resource
    extend Concerns::Naming
    extend Concerns::Crud
    extend SingleForwardable

    delegate [:where, :order, :limit, :offset, :paginate, :each, :all, :first, :last, :count, :delete_all, :empty?, :total] => :scoped

    def self.scoped
      Paymill::Scope.new(self)
    end

    include Concerns::Attributes
    include Concerns::Persistence

    attr_accessor :id, :created_at, :updated_at
  end
end

