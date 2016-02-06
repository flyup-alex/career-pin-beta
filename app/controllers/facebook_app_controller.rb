class FacebookAppController < ApplicationController

include FacebookAppHelper

before_action :authenticate_user!

  def new

  	if current_user.providers.where(provider: "facebook").any?
  		redirect_to facebookfollowed_path
  	else
  		redirect_to '/auth/facebook'
  	end

  end

  def create

  	@facebook_data = request.env['omniauth.auth']
  	Provider.create_or_find(request.env['omniauth.auth'], current_user)
  	redirect_to facebookfollowed_path

  end

  def followed

    @graph = facebook_data(current_user)
    @hash = get_wall(current_user, 45309870078)
  end
end
