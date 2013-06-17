require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Jiro" do
  # Clearance.configure do |config|
  #   config.mailer_sender = 'donotreply@example.com'
  # end

  # Clearance.configuration.mailer_sender= 'new.email@example.com'

  # Clearance.configuration.mailer_sender

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
end
