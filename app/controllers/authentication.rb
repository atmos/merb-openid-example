class Authentication < Merb::Controller
  def signup
    redirect!(url(:signin)) if session['openid.url'].nil?
    
    session.user = User.first_or_create({:identity_url => session['openid.url']},
                                {:email => session['openid.email'], :name => session['openid.nickname']})

    session.user.save
    redirect(url(:users))
  end
end