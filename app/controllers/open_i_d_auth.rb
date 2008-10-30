class OpenIDAuth < Application
  def index
    pp session
    pp session.user
    redirect '/'
  end
end