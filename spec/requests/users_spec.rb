require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Users do
  before(:each) do
    User.all.destroy!
    @user_params = { :name => 'atmos', :email => 'joe@atmoose.org', 
                     :identity_url => 'http://foo.myopenid.com' }
    User.create(@user_params)
  end
end
