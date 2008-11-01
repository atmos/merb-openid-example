require File.dirname(__FILE__) + '/../spec_helper'

describe Authentication do
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
        @response.status.should == 302
      end
      it "should redirect somewhere" do
        @response.should have_xpath("//a[@href='/login']")
      end
    end

    describe "a session with a valid user" do
      before(:each) do
        @response = @response = dispatch_to(Authentication, :login) do |controller|
          stub(controller.session).[](:user) { User.first.id }
        end
      end
      it "should return http redirect" do
        @response.status.should == 302
      end
      it "should redirect somewhere" do
        @response.should have_xpath("//a[@href='/users/#{@response.session.user.id}']")
      end
    end
    
  end
  describe "#register" do
    describe "a user with no session data" do
      before(:each) do
        @response = request(url(:signup), :method => 'GET')
      end
      it "should return http redirect" do
        @response.status.should == 302
      end
      it "should redirect to the login screen" do
        @response.body.to_s.should match(%r!href="/login"!)
      end
    end
    describe "valid user data returned" do
      before(:each) do
        @response = dispatch_to(Authentication, :register) do |controller|
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
        @response.body.should have_xpath("//a[@href='/users/#{@response.session.user.id}']")
      end
    end

    describe "invalid user data returned" do
      before(:each) do
        @response = dispatch_to(Authentication, :register) do |controller|
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
        @response.body.should have_xpath("//a[@href='/login']")
      end
      it "should give the user a message about validation errors"
    end
    
  end
end