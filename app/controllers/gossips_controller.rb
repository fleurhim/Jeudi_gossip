class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:create, :new, :edit]
  before_action :is_author?, only: [:edit, :destroy, :update]

  def show
  	@gossip = Gossip.find(params[:id])
  end

  def index
  	@gossips = Gossip.all
  	@gossip = Gossip.new
  end

  def create
  	@gossip = Gossip.new('title' => params[:title], 'content' => params[:content], 'user_id' => current_user.id)

  	if @gossip.save
			redirect_to gossips_path, notice: "Well done! You successfully created a new gossip! "
		else
	  	render 'new'
		end
  end

  def new
  	@gossip = Gossip.new
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])

    if @gossip.update(gossip_params)
    redirect_to gossip_path, notice: "Well done! You successfully edited the gossip! "
    else
    render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to gossips_path
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in!"
      redirect_to new_session_path
    end
  end

  def is_author?
    unless current_user.id == Gossip.find(params[:id]).user.id
      redirect_to gossip_path(params[:id])
      flash[:danger] = "Action non autorisée"
    end
  end
end
