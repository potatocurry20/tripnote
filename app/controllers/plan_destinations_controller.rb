class PlanDestinationsController < ApplicationController
  def new
    @plan_destination = PlanDestination.new
    @plan_id = params[:plan_id]
  end
  
  def index
    @plan_destinations = PlanDestination.all
    @plan_id = params[:plan_id]
  end
  
  def create
    #plan_idと紐づけるにはどうすれば良いか？
    plan_destination = PlanDestination.new
    plan_destination.user_id = current_user.id
    plan_destination.plan_id = params[:plan_destination][:plan_id]
    plan_destination.destination_title = params[:plan_destination][:destination_title]
    plan_destination.image = params[:plan_destination][:image]
    plan_destination.description = params[:plan_destination][:description]
    
    if plan_destination.save
      redirect_to plan_destinations_path
    else
      render :new
    end
  end
  
  
  
  private
    def plan_params
      params.require(:plan_destination).permit(:image, :destination_title, :description)
    end
end
