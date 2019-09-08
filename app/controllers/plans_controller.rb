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
      redirect_to plans_path
    else
      render :new
    end
  end
  
  
  
  private
    def plan_params
      params.require(:plan).permit(:image, :plan_title)
    end
  
end

