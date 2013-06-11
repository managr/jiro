require 'spec_helper'

describe Jiro::RedisConnection do
  it "returns redis connection" do
    connection = Jiro::RedisConnection.get
    connection.should_not be_nil
  end
end
