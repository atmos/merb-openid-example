require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe User do
  describe "#create" do
    before(:each) do
      @user_params = { :name => 'atmos', :email => 'joe@atmoose.org', 
                       :identity_url => 'http://foo.myopenid.com', 
                       :password => 'zomgwtfbbq', :password_confirmation => 'zomgwtfbbq' }
      @user = User.create(@user_params)
    end
    it "should description" do
      @user.should be_valid
    end
  end

end