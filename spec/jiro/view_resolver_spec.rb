require 'spec_helper'

describe Jiro::ViewResolver do
  let(:view_resolver) {
    Jiro::ViewResolver.new
  }
  let(:redis_connection) {
    double
  }
  before {
    Jiro::RedisConnection.stub(:get).and_return(redis_connection)
  }

  context "when not having page in cache" do
    it "not stores new page if not exists" do
      redis_connection.should_receive(:hget).and_return(nil)
      result = view_resolver.find_templates("name", "prefix", "partial", {})
      redis_connection.should_not_receive(:hput)
      result.should be_empty
    end  
  end
end
