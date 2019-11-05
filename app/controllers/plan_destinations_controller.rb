class PlanDestinationsController < ApplicationController
  before_action :logged_in_user
  before_action :ensure_correct_user, only:[:gone, :edit, :update]
  
  #これから行きたい目的地の一覧を表示する
  def destination_index
    @plan_destinations = PlanDestination.where(plan_id: params[:id]).where(gone: false)
    @plan_id = params[:id]
  end
  
  #これから行きたい目的地の登録フォームを開く
  def destination_new
    @plan_destination = PlanDestination.new
    @plan_id = params[:id]
  end
  
  #これから行きたい目的地を登録する
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
  
  #既に行った目的地の一覧を表示する
  def place_index
    @plan_destinations = PlanDestination.where(plan_id: params[:id]).where(gone: true)
    @plan_id = params[:id]
  end
  
  #既に行った目的地の登録フォームを開く
  def place_new
    @plan_destination = PlanDestination.new
    @plan_id = params[:id]
  end
  
  #既に行った目的地を登録する
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
  
  #目的地の詳細ページを開く
  def show
    @plan_destination = PlanDestination.find(params[:id])
  end
  
  #目的地の「行った」を登録する
  def gone
    @plan_destination = PlanDestination.find(params[:id])
    @plan_destination.gone = true
    if @plan_destination.save
      redirect_to("/#{@plan_destination.plan_id}/place_index")
    else
      redirect_to("/#{@plan_destination.plan_id}/destination_index")
    end
  end
  
  #目的地の編集ページを開く
  def edit
    @plan_destination = PlanDestination.find(params[:id])
  end
  
  #目的地を編集する
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
  
  #目的地を削除する
  def destroy
    @plan_destination = PlanDestination.find(params[:id])
    if @plan_destination.gone == false
      @plan_destination.destroy
      flash[:success] = "Destination deleted"
      redirect_to plans_path
    elsif @plan_destination.gone == true
      @plan_destination.destroy
      flash[:success] = "Destination deleted"
      redirect_to("/#{current_user.id}/visited/index")
    end
  end
  
  private
    def plan_destination_params
      params.require(:plan_destination).permit(:image, :destination_title, :description)
    end
    
   #投稿に紐づくユーザーが正しいかどうかの確認
   def ensure_correct_user
     @plan_destination = PlanDestination.find(params[:id])
     if @plan_destination.user_id != current_user.id
       flash[:danger]="You are not authorized."
       redirect_to(root_url) 
     end
   end
end
