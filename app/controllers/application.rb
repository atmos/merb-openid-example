class Application < Merb::Controller
  before :ensure_authenticated
  def openid
    ""
  end
end