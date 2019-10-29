class PlansController < ApplicationController
  before_action :logged_in_user
  before_action :ensure_correct_user, only:[:edit, :update]
  
  def new
    @plan = Plan.new
  end
  
  def visited_new
    @plan = Plan.new
  end
  
  def index
    @plans = current_user.plans
  end
  
  def visited_index
     @user = User.find_by(id: params[:id])
     @plans = Plan.where(user_id: @user.id)
  end
  
  def create
    @plan = current_user.plans.new(plan_params)
    if @plan.save
      flash[:success]="You created the new plan."
      redirect_to plans_path
    else
      render :new
    end
  end
  
  def visited_create
    @plan = current_user.plans.new(plan_params)
    if @plan.save
      flash[:success]="You created the new plan."
      redirect_to plans_path
    else
      render :new
    end
  end
  
  def edit
    @plan = Plan.find(params[:id])
  end
  
  def update
    @plan = Plan.find(params[:id])
    if @plan.update_attributes(plan_params)
      redirect_to plans_path
    else
      render 'edit'
    end
  end
  
  def destroy
    Plan.find(params[:id]).destroy
    redirect_to plans_path
  end
  
  
  
  private
    def plan_params
      params.require(:plan).permit(:image, :plan_title)
    end
    
   #投稿に紐づくユーザーが正しいかどうかの確認
   def ensure_correct_user
     @plan = PlanDestination.find(params[:id])
     if @plan.user_id != current_user.id
       flash[:danger]="You are not authorized."
       redirect_to(root_url) 
     end
   end
  
end

