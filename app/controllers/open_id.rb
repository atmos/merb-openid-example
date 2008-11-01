class OpenId < Merb::Controller
  before :ensure_authenticated, :only => [:login]
  before :ensure_openid_url,    :only => [:register]
  
  def login
    redirect(url(:user, session.user.id))
  end
  
  def register
    attributes = {
      :name         => session['openid.nickname'],
      :email        => session['openid.email'],
      :identity_url => session['openid.url'],
    }

    user = Merb::Authentication.user_class.first_or_create(
      attributes.only(:identity_url),
      attributes.only(:name, :email)
    )

    if user.update_attributes(attributes)
      session.user = user
      login
    else
      redirect(url(:login))
    end
  end
  private
 
  def ensure_openid_url
    throw :halt, redirect(url(:login)) if session['openid.url'].nil?
  end
end