class PlansController < ApplicationController
  def new
    @plan = Plan.new
  end
  
  def index
    @plans = Plan.all
  end
  
  def create
    #ここのcurrent_userはどこからきているのか？
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
  
end

