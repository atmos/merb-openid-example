class Authentication < Merb::Controller
  before :ensure_authenticated, :exclude => [:signup]
  
  def index
    redirect '/'
  end
  
  def signup
    return redirect(url(:login)) if session['openid.url'].nil?
    
    session.user = User.first_or_create({:identity_url => session['openid.url']},
                                {:email => session['openid.email'], :name => session['openid.nickname']})

    session.user.save
    session.user.valid? ? redirect(url(:users)) : redirect(url(:login))
  end
end