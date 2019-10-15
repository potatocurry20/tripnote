class FavoritesController < ApplicationController
  
  def index
    @favorite_topics = current_user.favorite_topics
  end
  
  def plan_create
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.plan_id = params[:plan_id]
    
    if favorite.save
      flash[:success]="You registered as a favorite."
      redirect_to plans_path
    else
      flash[:success]="You failed to register to favorites."
      redirect_to plans_path
    end
  end
  
  def destination_create
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.plan_destination_id = params[:id]

    if favorite.save
      flash[:success]="You registered as a favorite."
      redirect_to request.referrer || root_url
    else
      flash[:danger]="You failed to register to favorites."
      redirect_to request.referrer || root_url
    end
  end
  
end
