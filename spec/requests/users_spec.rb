require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Users do
  before(:each) do
    User.all.destroy!
    @user_params = { :name => 'atmos', :email => 'joe@atmoose.org', 
                     :identity_url => 'http://foo.myopenid.com' }
    User.create(@user_params)
  end

  describe "resource(:users)" do
    describe "GET" do
  
      before(:each) do
        @response = dispatch_to(Users, :index) do |controller|
          stub(controller.session).user { User.first }
        end
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
        @response = dispatch_to(Users, :create, { :user => @user_params }) do |controller|
          mock(controller).ensure_authenticated { true }
        end
      end
  
      it "redirects to resource(:users)" do
        @response.should redirect_to(url(:user, User.first.id), :message => {:notice => "user was successfully created"})
      end
  
    end
  end

  describe "resource(@user)" do 
    describe "a successful DELETE" do
       before(:each) do
         @response = dispatch_to(Users, :destroy, {:id => User.first.id}) do |controller|
           mock(controller).ensure_authenticated { true }
         end
       end
  
       it "should redirect to the index action" do
         @response.should redirect_to(resource(:users))
       end
     end
  end
  
  describe "resource(:users, :new)" do
    before(:each) do
      @response = dispatch_to(Users, :new, {}) do |controller|
        mock(controller).ensure_authenticated { true }
      end
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "resource(@user, :edit)" do
    before(:each) do
      @response = dispatch_to(Users, :edit, {:id => User.first.id}) do |controller|
        mock(controller).ensure_authenticated { true }
      end
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end

  describe "resource(@user)" do

    describe "GET" do
      before(:each) do
        @response = dispatch_to(Users, :show, {:id => User.first.id}) do |controller|
          stub(controller.session).[](:user) { User.first.id }
          mock(controller).ensure_authenticated { true }
        end
      end

      it "responds successfully" do
        @response.should be_successful
      end
    end

    describe "PUT" do
      before(:each) do
        @response = dispatch_to(Users, :update, {:id => User.first.id, :user => {:id => User.first.id }}) do |controller|
          mock(controller).ensure_authenticated { true }
        end
      end

      it "redirect to the article show action" do
        @response.should redirect_to(url(:user, User.first.id), :message => {:notice => "User was successfully updated"})
      end
    end
  end
end
