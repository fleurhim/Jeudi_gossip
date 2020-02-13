class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(
      'email' => params[:email], 
      'password' => params[:password], 
      'first_name' => params[:first_name], 
      'last_name' => params[:last_name], 
      'city_id' => City.find_by('name' => params[:city]).id
      )

  	if @user.save
  		session[:user_id] = @user.id
  		redirect_to gossips_path, notice: "Well done! You successfully signed up! "
  	else
  		render 'new'
  end
end
end
