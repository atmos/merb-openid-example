require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Users do
  before(:each) do
    User.all.destroy!
    @user_params = { :name => 'atmos', :email => 'joe@atmoose.org', 
                     :identity_url => 'http://foo.myopenid.com', 
                     :password => 'zomgwtfbbq', :password_confirmation => 'zomgwtfbbq' }
    User.create(@user_params)
  end

  
  describe "resource(:users)" do
    describe "GET" do

      before(:each) do
        @response = request(resource(:users))
      end

      it "responds successfully" do
        @response.should be_successful
      end

      it "contains a list of users" do
        pending
        @response.should have_xpath("//ul")
      end

    end

    describe "GET" do
      before(:each) do
        @response = request(resource(:users))
      end

      it "has a list of users" do
        pending
        @response.should have_xpath("//ul/li")
      end
    end

    describe "a successful POST" do
      before(:each) do
        User.all.destroy!
        @response = request(resource(:users), :method => "POST", 
          :params => { :user => @user_params })
      end

      it "redirects to resource(:users)" do
        @response.should redirect_to(resource(User.first), :message => {:notice => "user was successfully created"})
      end

    end
  end

  describe "resource(@user)" do 
    describe "a successful DELETE" do
       before(:each) do
         @response = request(resource(User.first), :method => "DELETE")
       end

       it "should redirect to the index action" do
         @response.should redirect_to(resource(:users))
       end

     end
  end

  describe "resource(:users, :new)" do
    before(:each) do
      @response = request(resource(:users, :new))
    end

    it "responds successfully" do
      @response.should be_successful
    end
  end

  describe "resource(@user, :edit)" do
    before(:each) do
      @response = request(resource(User.first, :edit))
    end

    it "responds successfully" do
      @response.should be_successful
    end
  end

  describe "resource(@user)" do

    describe "GET" do
      before(:each) do
        @response = request(resource(User.first))
      end

      it "responds successfully" do
        @response.should be_successful
      end
    end

    describe "PUT" do
      before(:each) do
        @response = request(resource(User.first), :method => "PUT", 
          :params => { :user => {:id => User.first.id } })
      end

      it "redirect to the article show action" do
        @response.should redirect_to(resource(User.first))
      end
    end

  end
end
