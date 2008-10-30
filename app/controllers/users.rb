class Users < Application
  # provides :xml, :yaml, :js
  # before :ensure_authenticated, :only => [:signup]

  def index
    @users = User.all
    display @users
  end

  def show(id)
    @user = User.get(id)
    raise NotFound unless @user
    display @user
  end

  def new
    only_provides :html
    @user = User.new
    display @user
  end

  def edit(id)
    only_provides :html
    @user = User.get(id)
    raise NotFound unless @user
    display @user
  end

  def create(user)
    @user = User.new(user)
    if @user.save
      redirect resource(@user), :message => {:notice => "User was successfully created"}
    else
      pp @user.errors
      message[:error] = "User failed to be created"
      render :new
    end
  end

  def update(id, user)
    @user = User.get(id)
    raise NotFound unless @user
    @user.update_attributes(user)
    if @user.errors.empty?
       redirect resource(@user)
    else
      display @user, :edit
    end
  end

  def destroy(id)
    @user = User.get(id)
    raise NotFound unless @user
    if @user.destroy
      redirect resource(:users)
    else
      raise InternalServerError
    end
  end

end # Users
