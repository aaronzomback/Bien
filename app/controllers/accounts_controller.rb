class AccountsController < ApplicationController

before_action :find_current_user

def show
    redirect_to edit_account_path
end

def edit

end

def update

# we dont want users to be able to edit/add themselves as admin so
# we must define the exact form_params below
  if @current_user.update(form_params)
    flash[:success] = "Your account was updated!"
  end

  render "edit"
end

def form_params
  params.require(:user).permit(:username, :email, :avatar)
end

end
