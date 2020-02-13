class CommentsController < ApplicationController
    before_action :authenticate_user, only: [:new, :create, :edit, :destroy]

  def new
  	@comment = Comment.new
  end

  def create
  	 @comment = Comment.new('content' => params[:content], 'gossip_id' => params[:gossip_id], 'user_id' => current_user.id)

  	if @comment.save
  		redirect_to gossip_path(params[:gossip_id])
  	else
  		render 'new'
  	end
  end

  def edit
  	@comment = Comment.find(params[:id])
  end

  def update
  	@comment = Comment.find(params[:id])
    if @comment.update(comment_params)
    redirect_to gossip_path(@comment.gossip_id), notice: "Well done! You successfully edited the comment! "
    else
    render :edit
    end
  end

  def destroy
  	@comment = Comment.find(params[:id])
  	@comment.destroy
  	redirect_to gossip_path(@comment.gossip_id)
  end

    private

  def comment_params
    params.require(:comment).permit(:content, :gossip_id)
  end

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in!"
      redirect_to new_session_path
    end
  end
end
