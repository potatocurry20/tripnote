class DestinationFavoritesController < ApplicationController
  def index
    @favorite_destinations = current_user.favorite_destinations
  end
  
  def create
    favorite = DestinationFavorite.new
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
  
  def destroy
    @favorite = DestinationFavorite.find_by(plan_destination_id: params[:id])
    @favorite.destroy
    flash[:success]="You removed the favorite."
    redirect_to request.referrer || root_url
  end
end
