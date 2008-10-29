class Authentication < Application
  skip_before :ensure_authenticated
  
  def signup
    render
  end
end