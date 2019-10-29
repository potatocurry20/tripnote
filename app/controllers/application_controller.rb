class ApplicationController < ActionController::Base
  include SessionsHelper
  
  #ログインユーザーがいる場合、現在のユーザーにログインユーザーを代入する
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  #現在のユーザーがnilでない＝現在のユーザーがいるならばtrueを返す
  def logged_in?
    !current_user.nil?
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
