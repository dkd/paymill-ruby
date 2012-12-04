require "spec_helper"

describe Paymill::Coupon do
  let(:fixed_value_attributes) do
    { name: 'My fixed value Coupon', type: 'fixed_value', fixed_value: 42}
  end
  
  let(:percent_value_attributes) do
    { name: 'My percent value Coupon', type: 'percent_value', percent_value: 42}
  end
    
  let (:coupon) do
    Paymill::Coupon.new(fixed_value_attributes)
  end
    
    
  describe "initialize" do
    it "initializes all attributes correctly" do
      coupon.name.must_equal "My fixed value Coupon"
      coupon.type.must_equal "fixed_value"
      coupon.fixed_value.must_equal 42
    end
  end
  
  describe "Naming" do
    it "should return the correct collection_name" do
      Paymill::Coupon.collection_name.must_equal 'coupons'
    end

    it "should return the correct api_path" do
      Paymill::Coupon.api_path.must_equal 'coupons'
      Paymill::Coupon.api_path(123).must_equal 'coupons/123'
    end
  end  
    
    
  describe "find" do
    it "makes a new GET request using the correct API endpoint to receive a specific client" do
      url = "https://api.paymill.com/v2/coupons/123"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Coupon.find("123")
      assert_requested :get, url
    end
  end
    
  describe "all" do
    it "makes a new GET request using the correct API endpoint to receive all clients" do
      url = "https://api.paymill.com/v2/coupons?order=created_at_asc"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": []}', :headers => {})
      Paymill::Coupon.all
      assert_requested :get, url
    end
  end
    
  describe "delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      url = "https://api.paymill.com/v2/coupons/123"
      stub_request(:delete, url).to_return(:status => 200, :body => '{"data": []}', :headers => {})
      Paymill::Coupon.delete("123")
      assert_requested :delete, url
    end
  end
    
  describe "create" do
    it "makes a new POST request using the correct API endpoint" do
      url = "https://api.paymill.com/v2/coupons"
      stub_request(:post, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Coupon.create(fixed_value_attributes)
      assert_requested :post, url
    end
  end
  
  describe "update" do
    it "makes a new PUT request using the correct API endpoint" do
      url = "https://api.paymill.com/v2/coupons/123"
      stub_request(:put, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Coupon.update(123, fixed_value_attributes)
      assert_requested :put, url
    end
  end
end
