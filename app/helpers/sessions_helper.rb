module SessionsHelper
  
  #ログイン時にセッションのユーザーIDにログインユーザーのIDを代入する
  def login(user)
    session[:user_id] = user.id
  end
  
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
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
