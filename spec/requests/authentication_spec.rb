require File.dirname(__FILE__) + '/../spec_helper'

describe Authentication do
  before(:each) do
    User.all.destroy!
    @user_params = { :name => 'atmos', :email => 'joe@atmoose.org', 
                     :identity_url => 'http://foo.myopenid.com' }
    User.create(@user_params)
  end

  describe "#signup" do
    before(:each) do
      @response = dispatch_to(Authentication, :signup) do |controller|
        mock(controller.session).[](:user).times(3) { User.first.id }
        mock(controller.session).[]('openid.url').twice { 'http://ceel0.myopenidizzle.com' }
        mock(controller.session).[]('openid.email') { 'gangsters@ceelo.com' }
        mock(controller.session).[]('openid.nickname') { 'ceelo' }
      end
    end
    it "should return http redirect" do
      @response.status.should == 302
    end
    it "should redirect to the root user" do
      @response.body.should have_xpath("//a[@href='/users']")
    end
  end

  describe "#signup" do
    before(:each) do
      @response = dispatch_to(Authentication, :signup) do |controller|
        mock(controller.session).[](:user).times(3) { User.first.id }
        mock(controller.session).[]('openid.url').twice { 'http://ceel0.myopenidizzle.com' }
        mock(controller.session).[]('openid.email') { 'gangsters@ceelo.com' }
        mock(controller.session).[]('openid.nickname') { 'atmos' }
      end
    end
    it "should return http redirect" do
      @response.status.should == 302
    end
    it "should redirect to the root user" do
      @response.body.should have_xpath("//a[@href='/login']")
    end
    it "should give the user a message about validation errors"
  end
end