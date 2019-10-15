class PlanDestinationsController < ApplicationController
  def destination_index
    @plan_destinations = PlanDestination.where(plan_id: params[:id]).where(gone: false)
    @plan_id = params[:id]
  end
  
  def destination_new
    @plan_destination = PlanDestination.new
    @plan_id = params[:id]
  end
  
  def place_index
    @plan_destinations = PlanDestination.where(plan_id: params[:id]).where(gone: true)
    @plan_id = params[:id]
  end
  
  def place_new
    @plan_destination = PlanDestination.new
    @plan_id = params[:id]
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
      redirect_to("/#{plan_destination.plan_id}/destination_index")
    else
      render("plan_destinations/destination_new")
    end
  end
  
   def place_create
    plan_destination = PlanDestination.new
    plan_destination.user_id = current_user.id
    plan_destination.plan_id = params[:plan_destination][:plan_id]
    plan_destination.destination_title = params[:plan_destination][:destination_title]
    plan_destination.image = params[:plan_destination][:image]
    plan_destination.description = params[:plan_destination][:description]
    plan_destination.gone = true
    if plan_destination.save
      redirect_to("/#{plan_destination.plan_id}/place_index")
    else
      render("plan_destinations/place_new")
    end
   end
   
  def show
    @plan_destination = PlanDestination.find(params[:id])
  end
  
  def gone
    @plan_destination = PlanDestination.find(params[:id])
    @plan_destination.gone = true
    if @plan_destination.save
      redirect_to("/#{@plan_destination.plan_id}/place_index")
    else
      redirect_to("/#{@plan_destination.plan_id}/destination_index")
    end
  end
  
  def edit
    @plan_destination = PlanDestination.find(params[:id])
  end
  
  def update
    @plan_destination = PlanDestination.find(params[:id])
    if @plan_destination.update_attributes(plan_destination_params) && @plan_destination.gone == false
      redirect_to("/#{@plan_destination.plan_id}/destination_index")
    elsif
      @plan_destination.update_attributes(plan_destination_params) && @plan_destination.gone == true 
      redirect_to("/#{@plan_destination.plan_id}/place_index")
    else
      render 'edit'
    end
  end
  
  def destroy
    @plan_destination = PlanDestination.find(params[:id])
    @plan_destination.destroy
    flash[:success] = "Destination deleted"
    redirect_to request.referrer || root_url
  end
  
  private
    def plan_destination_params
      params.require(:plan_destination).permit(:image, :destination_title, :description)
    end
end
