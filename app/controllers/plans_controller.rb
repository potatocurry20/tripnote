class PlansController < ApplicationController
  before_action :logged_in_user
  before_action :ensure_correct_user, only:[:edit, :update]
  
  #新しい行く場所の登録ページへ移動する
  def new
    @plan = Plan.new
  end
  
  #新しい行った場所の登録ページへ移動する
  def visited_new
    @plan = Plan.new
  end
  
  #現在のユーザーの行く場所一覧を表示する
  def index
    @plans = current_user.plans
  end
  
  #ユーザーの行った場所一覧を表示する
  def visited_index
     @user = User.find_by(id: params[:id])
     @plans = @user.plans.where(user_id: @user.id)
  end
  
  #現在のユーザーの行く場所を登録する
  def create
    @plan = current_user.plans.new(plan_params)
    if @plan.save
      flash[:success]="You created the new plan."
      redirect_to plans_path
    else
      render :new
    end
  end
  
  #現在のユーザーの行った場所を登録する
  def visited_create
    @plan = current_user.plans.new(plan_params)
    if @plan.save
      flash[:success]="You created the new plan."
      redirect_to plans_path
    else
      render :new
    end
  end
  
  #プランの編集ページに移動する
  def edit
    @plan = Plan.find(params[:id])
  end
  
  #プランを編集する
  def update
    @plan = Plan.find(params[:id])
    if @plan.update_attributes(plan_params)
      redirect_to plans_path
    else
      render 'edit'
    end
  end
  
  #プランを削除する
  def destroy
    Plan.find(params[:id]).destroy
    redirect_to plans_path
  end
  
  
  
  private
    def plan_params
      params.require(:plan).permit(:image, :plan_title)
    end
    
   #投稿に紐づくユーザーが正しいかどうかを確認する
   def ensure_correct_user
     @plan = PlanDestination.find(params[:id])
     if @plan.user_id != current_user.id
       flash[:danger]="You are not authorized."
       redirect_to(root_url) 
     end
   end
  
end

