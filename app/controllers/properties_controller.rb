class PropertiesController < ApplicationController

	get '/properties' do 
		redirect_if_not_logged_in

		

		@properties = []
		@pm = User.find(session[:user_id])
		Property.all.each do |item| 
			if item.user_id == session[:user_id] || item.user == nil
				@properties << item
			end
		end

		
		erb :'/properties/index'
	end

	get '/properties/new' do
		redirect_if_not_logged_in
		@pm = User.find(session[:user_id])
		erb :'/properties/new'
	end

	post '/properties' do
		
		property = Property.create(:name => params[:name], :address => params[:address])
		if params.has_key?("user_name")
			user = User.find(session[:user_id])
			property.user = user
			property.save
		end
		
		redirect to '/properties'
	end

	get '/properties/:id/edit' do
		
		redirect_if_not_logged_in
		@property = Property.find(params[:id].to_i)
		@pm = User.find(session[:user_id])
		
		erb :"/properties/edit"
	end

	patch '/properties/:id' do
		property = Property.find(params[:id].to_i)
		property.tenant_name = params[:tenant_name]
		property.tenant_email = params[:tenant_email]
		property.tenant_phone_number = params[:tenant_phone_number]
		property.security_deposit = params[:security_deposit]
		property.rent = params[:rent]
		property.lease_starting_date = params[:lease_starting_date]
		property.lease_ending_date = params[:lease_ending_date]
		if params[:user_name] != nil
			user = User.find(session[:user_id])
			property.user = user
		end
		property.save
		
		redirect "/properties/#{params[:id]}"
	end

	get '/properties/:id' do
		if Property.exists?(params[:id].to_i)
			@property = Property.find(params[:id].to_i)
			@pm = User.find(session[:user_id])
			erb :"/properties/show"
		else
			flash[:proeprty_not_exit] = "This property #{params[:id]} has been deleted! It is not a valid ID."
		end
	end

	delete '/properties/:id' do
		Property.find(params[:id]).destroy
		redirect '/properties'
	end
end
