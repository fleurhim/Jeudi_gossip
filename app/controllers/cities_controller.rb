class CitiesController < ApplicationController
  def show
  	@city = City.find(params[:id])
  	@city_gossips = []
  	Gossip.all.each do |gossip|
  		@city_gossips << gossip if gossip.user.city.id == @city.id
  	end
  end
end
