class LikesController < ApplicationController
	before_action :authenticate_user, only: [:create, :destroy]
	#before_action :already_liked?, only: [:create]

  def create
  	#gossip = Gossip.find_by('gossip_id' => params[:gossip_id])
  	if already_liked?
  		Like.find_by(gossip_id: params[:gossip_id], user_id: current_user.id).destroy
  		redirect_to request.referrer
  		flash[:danger] = "Unlike"
  	else
  		@like = Like.new('gossip_id' => params[:gossip_id], 'user_id' => current_user.id)
  		@like.save
  		redirect_to request.referrer
  		flash[:success] = "Like"
  	end
  end

  private

   def authenticate_user
    unless current_user
      flash[:danger] = "Please log in!"
      redirect_to new_session_path
    end
  end

  def already_liked?
  	if Like.where('gossip_id' => params[:gossip_id]).pluck('user_id').include?(current_user.id)
  		return true
  	else
  		return false
  	end
  end

end
