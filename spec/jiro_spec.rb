require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Jiro" do
  it "defines default application id" do
    Jiro.app_id.should eq("jiro_cms_pages")
  end

  it "allows to change application id" do
    Jiro.app_id = "call_me_jiro"
    Jiro.app_id.should eq("call_me_jiro")
  end

  it "defines default redis opts" do
    Jiro.redis_opts.should eq({})
  end

  it "allows to change redis opts" do
    Jiro.redis_opts = { :port => 999 }
    Jiro.redis_opts.should eq({ :port => 999})
  end
end
