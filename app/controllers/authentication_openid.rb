class AuthenticationOpenid < Merb::Controller
  before :ensure_authenticated
  def index
    redirect '/'
  end
end