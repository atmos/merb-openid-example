require File.dirname(__FILE__) + '/../spec_helper'

describe OpenId do
  before(:each) do
    User.all.destroy!
    @user_params = { :name => 'atmos', :email => 'joe@atmoose.org', 
                     :identity_url => 'http://foo.myopenid.com' }
    User.create(@user_params)
  end

  describe "#login" do
    # params = { 
    #   "openid.sreg.nickname"=>"atmos", "openid.claimed_id"=>"http://atmos.aol.com/", 
    #   "openid.mode"=>"id_res", "openid.ns.sreg"=>"http://openid.net/extensions/sreg/1.1", 
    #   "openid.return_to"=>"http://localhost:4000/openid", 
    #   "openid.sig"=>"QMAWNSbl(*^hj8jBnohvBNpmlun8=", 
    #   "openid.ns"=>"http://specs.openid.net/auth/2.0", 
    #   "openid.op_endpoint"=>"http://www.myopenid.com/server", 
    #   "action"=>:index, 
    #   "openid.response_nonce"=>"2008-10-30T02:22:12ZYF4XhB", 
    #   "controller"=>"open_i_d_auth", 
    #   "openid.sreg.email"=>"atmos@atmos.org", 
    #   "openid.identity"=>"http://atmos.myopenid.com/", 
    #   "openid.assoc_handle"=>"{HMAC-SHA1}{490a92nf5}{f/9pww==}", 
    #   "openid.signed"=>"assoc_handle,claimed_id,identity,mode,ns,ns.sreg,op_endpoint,response_nonce,return_to,signed,sreg.email,sreg.nickname"
    # }
    
    describe "a session without a valid user" do
      before(:each) do
        @response = request(url(:openid), :method => 'GET')
      end
      it "should return http redirect" do
        @response.status.should == 401
      end
      it "should redirect to the login page" do
        @response.should have_xpath("//form[@action='/openid/login']")
      end
    end

    describe "a session with a valid user" do
      before(:each) do
        @response = dispatch_to(Users, :login) do |controller|
          stub(controller.session).[](:user) { User.first.id }
          mock(controller).ensure_authenticated { true }
        end
      end
      it "should return http redirect" do
        @response.status.should == 302
      end
      it "should redirect to the users page" do
        @response.should have_xpath("//a[@href='/users/#{@response.session.user.id}?_message=BAh7BjoLbm90aWNlIhpZb3UgYXJlIG5vdyBsb2dnZWQgaW4%3D%0A']")
      end
    end

  end
  describe "#register" do
    describe "a user with no session data" do
      before(:each) do
        @response = request(url(:signup))
      end
      it "should return http redirect" do
        @response.status.should == 302
      end
      it "should redirect to the login screen" do
        @response.should have_selector('a[href="/openid/login"]')
      end
    end
    describe "valid user data returned" do
      before(:each) do
        @response = dispatch_to(OpenId, :register) do |controller|
          stub(controller.session).[](:user) { User.first.id }
          mock(controller.session).[]('openid.url').twice { 'http://ceel0.myopenidizzle.com' }
          mock(controller.session).[]('openid.email') { 'gangsters@ceelo.com' }
          mock(controller.session).[]('openid.nickname') { 'ceelo' }
        end
      end
      it "should return http redirect" do
        @response.status.should == 302
      end
      it "should redirect to the user listing" do
        @response.body.should have_xpath("//a[@href='/users/#{@response.session.user.id}?_message=BAh7BjoLbm90aWNlIhpTaWdudXAgd2FzIHN1Y2Nlc3NmdWw%3D%0A']")
      end
    end

    describe "invalid user data returned" do
      before(:each) do
        @response = dispatch_to(OpenId, :register) do |controller|
          # mock(controller.session).[](:user).times(3) { User.first.id }
          mock(controller.session).[]('openid.url').twice { 'http://ceel0.myopenidizzle.com' }
          mock(controller.session).[]('openid.email') { 'gangsters@ceelo.com' }
          mock(controller.session).[]('openid.nickname') { 'atmos' }
        end
      end
      it "should return http redirect" do
        @response.status.should == 302
      end
      it "should redirect to the login page" do
        @response.body.should have_xpath("//a[@href='/openid/login']")
      end
      it "should give the user a message about validation errors"
    end
    
  end
end
