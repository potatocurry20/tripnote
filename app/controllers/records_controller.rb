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
  
  
  
  private
    def record_params
      params.require(:record).permit(:image, :record_title)
    end
end
