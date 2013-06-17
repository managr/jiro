require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Jiro" do
  it "defines default application id" do
    Jiro.configuration.app_id.should eq("jiro_cms_pages")
  end

  it "allows to change application id" do
    Jiro.configuration.app_id = "call_me_jiro"
    Jiro.configuration.app_id.should eq("call_me_jiro")
  end

  it "defines default redis opts" do
    Jiro.configuration.redis_opts.should eq({})
  end

  it "allows to change redis opts" do
    Jiro.configuration.redis_opts = { :port => 999 }
    Jiro.configuration.redis_opts.should eq({ :port => 999})
  end

  it "defines default limit to handlers" do
    Jiro.configuration.limit_to_handlers.should eq(nil)
  end

  it "allows to change limit to handlers" do
    Jiro.configuration.limit_to_handlers = [:erb]
    Jiro.configuration.limit_to_handlers.should eq([:erb])
  end
end
