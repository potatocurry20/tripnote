class RecordsController < ApplicationController
  def new
    @record = Record.new
  end
  
  def index
    @records = Record.all
  end
  
  def create
    #ここのcurrent_userはどこからきているのか？
    @record = current_user.records.new(record_params)
    
    if @record.save
      redirect_to records_path
    else
      render :new
    end
  end
  
  def edit
    @record = Record.find(params[:id])
  end
  
  def update
    @record = Record.find(params[:id])
    if @record.update_attributes(record_params)
      redirect_to records_path
    else
      render 'edit'
    end
  end
  
  def destroy
    Record.find(params[:id]).destroy
    redirect_to records_path
  end
  
  
  
  private
    def record_params
      params.require(:record).permit(:image, :record_title)
    end
end
