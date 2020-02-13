class SessionsController < ApplicationController
	

	def new
	end

	def create
		user =  User.find_by(email: params[:email])

		if user && user.authenticate(params[:password])
    	log_in(user)
    	redirect_to gossips_path, notice: "Well done! You successfully signed up! "
  	else
    	redirect_to new_session_path, notice: "Oups! Invalid email or password"
  	end
	end

	def destroy
		session.delete(:user_id)
		redirect_to gossips_path, notice: "We hope to see you soon"
	end
end
