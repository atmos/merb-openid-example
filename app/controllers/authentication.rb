class Authentication < Merb::Controller
  def signup
    
    redirect!(url(:signin)) if session['openid.url'].nil?
    
    pass = Time.now.to_s.crypt(Time.now.to_s)
    @user = User.first_or_create({:identity_url => session['openid.url']},
                                {:email => session['openid.email'], :name => session['openid.nickname'],
                                  :password => pass, :password_confirmation => pass})
    @user.save
    Merb.logger.info @user.errors.inspect
    redirect(url(:users))
  end
end