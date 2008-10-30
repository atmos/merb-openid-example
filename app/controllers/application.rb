require 'pp'
class Application < Merb::Controller
  before :ensure_authenticated
  before :session_dump
  def session_dump
    pp session
  end
end