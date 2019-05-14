class PropertiesController < ApplicationController

	get '/properties' do 
		redirect_if_not_logged_in
		@properties = []
		binding.pry
		if session[:is_admin]
			@properties = Property.all
		else
			@properties = Property.all.map {|item| item.user_id == session[:user_id]}
		end
		binding.pry
		erb :'/properties/index'
	end

	get '/admin/properties/new' do
		redirect_if_not_logged_in
		if !is_admin?
			redirect to '/properties'
		end
		@pms = []
		User.all.each do |user|
			if !user.is_admin
				@pms << user
			end
		end
		erb :'/properties/new'
	end

	post '/properties' do
		property = Property.create(:name => params[:name], :address => params[:address])
		binding.pry
		redirect to '/properties'
	end

	get '/properties/:id/edit' do
		binding.pry
		redirect_if_not_logged_in
		@is_admin = session[:is_admin]
		@property = Property.find(params[:id].to_i)
		@pms = User.all
		binding.pry
		erb :"/properties/edit"
	end

	patch '/properties/:id/edit' do
		binding.pry
	end
end
