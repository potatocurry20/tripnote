class UsersController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update]
  before_action :correct_user, only:[:edit, :update]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
   def user_params
     params.require(:user).permit(:name, :email, :image, :password, :password_confirmation)
   end
   
   #ログイン済みユーザーかどうかの確認
   def logged_in_user
     unless logged_in?
       flash[:danger]="Please log in."
       redirect_to login_url
     end
   end
   
   #正しいユーザーかどうかの確認
   def correct_user
     @user = User.find(params[:id])
     unless current_user?(@user)
       flash[:danger]="You are wrong user."
       redirect_to(root_url) 
     end
   end
end
