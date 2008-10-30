class Authentication < Merb::Controller
  def signin
    render
  end
  
  def signout
    session.clear
    redirect(url(:signup))
  end
  
  def signup
    Merb.logger.info! session.inspect
    
    redirect!(url(:signin)) if session['openid.url'].nil?
    
    pass = Time.now.to_s.crypt(Time.now.to_s)
    @user = User.first_or_create({:identity_url => session['openid.url']},
                                {:email => session['openid.email'], :name => session['openid.nickname'],
                                  :password => pass, :password_confirmation => pass})
    @user.save
    redirect(url(:users))
  end
end