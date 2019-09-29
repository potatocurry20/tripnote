class RecordDestinationsController < ApplicationController
  def new
    @record_destination = RecordDestination.new
    @record_id = params[:record_id]
  end
  
  def index
    @record_destinations = RecordDestination.where(record_id: params[:record_id])
    @record_id = params[:record_id]
  end
  
  def create
    record_destination = RecordDestination.new
    record_destination.user_id = current_user.id
    record_destination.record_id = params[:record_destination][:record_id]
    record_destination.destination_title = params[:record_destination][:destination_title]
    record_destination.image = params[:record_destination][:image]
    record_destination.description = params[:record_destination][:description]
    
    if record_destination.save
      redirect_to record_destinations_path(record_id: record_destination.record_id)
    else
      render :new
    end
  end
  
  def edit
    @record_destination = RecordDestination.find(params[:id])
  end
  
  def update
    @record_destination = RecordDestination.find(params[:id])
    if @record_destination.update_attributes(record_destination_params)
      redirect_to record_destinations_path(record_id: @record_destination.record_id)
    else
      render 'edit'
    end
  end
  
   #削除した目的地が掲載されていた一覧ページにリダイレクトしたい
  def destroy
    @record_destination.record_id = RecordDestination.find(params[:id])
    @record_destination.destroy
    redirect_to record_destinations_path(record_id: @record_destination.plan_id)
  end
  
  private
    def record_destination_params
      params.require(:record_destination).permit(:image, :destination_title, :description)
    end
end

