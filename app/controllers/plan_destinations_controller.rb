class PlanDestinationsController < ApplicationController
  def new
    @plan_destination = PlanDestination.new
    @plan_id = params[:plan_id]
  end
  
  def index
    @plan_destinations = PlanDestination.where(plan_id: params[:plan_id])
    @plan_id = params[:plan_id]
  end
  
  def create
    #省略表記したい
    plan_destination = PlanDestination.new
    plan_destination.user_id = current_user.id
    plan_destination.plan_id = params[:plan_destination][:plan_id]
    plan_destination.destination_title = params[:plan_destination][:destination_title]
    plan_destination.image = params[:plan_destination][:image]
    plan_destination.description = params[:plan_destination][:description]
    
    if plan_destination.save
      redirect_to plan_destinations_path(plan_id: plan_destination.plan_id)
    else
      render :new
    end
  end
  
  def edit
    @plan_destination = PlanDestination.find(params[:id])
  end
  
  def update
    @plan_destination = PlanDestination.find(params[:id])
    if @plan_destination.update_attributes(plan_destination_params)
      redirect_to plan_destinations_path(plan_id: @plan_destination.plan_id)
    else
      render 'edit'
    end
  end
  
   #削除した目的地が掲載されていた一覧ページにリダイレクトしたい
  def destroy
    @plan_destination.plan_id = PlanDestination.find(params[:id])
    @plan_destination.destroy
    redirect_to plan_destinations_path(plan_id: @plan_destination.plan_id)
  end
  
  private
    def plan_destination_params
      params.require(:plan_destination).permit(:image, :destination_title, :description)
    end
end
