class UsersController < ApplicationController


def index
  @users = User.all
end

# to create our user show page (user profile page)
def show
 @user = User.find(params[:id])
end

  def new
    @user = User.new
  end


def create

# take the params from the form
# create a new user
  @user = User.new(form_params)

# if it's valid and it saves, go the list users page
# if not, see the form errors
  if @user.save
    # save the session with the user
    session[:user_id] = @user.id
    redirect_to users_path
  else
    render "new"
  end


end

  def form_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
  end

end
