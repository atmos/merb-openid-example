class Users < Application
  # provides :xml, :yaml, :js
  before :ensure_authenticated

  def login
    # if the user is logged in, then redirect them to their profile
    redirect url(:user, session.user.id), :message => { :notice => 'You are now logged in' }
  end
end # Users
