class UsersController < ApplicationController

	get '/signup' do
		binding.pry
		if !session[:user_id]
			erb :'users/new'
		else
			redirect '/properties'
		end
	end

	post '/signup' do
		binding.pry
		if params[:password] == "" || params[:email] ==""
			#need to post an error message
			redirect to '/signup'
		else
			if params[:user_name] == ""
				params[:user_name] = params[:email]
			end
			user = User.create(:user_name => params[:user_name], 
				:password => params[:password], :email => params[:email])
			session[:user_id] = user.id
			redirect '/properties'
		end
	end

	get '/login' do
		@users = User.all
		binding.pry
		if @users == nil || @users.size == 0
			redirect to '/signup'
		else
			erb :'/users/login'
		end
	end

	post '/login' do
		#binding.pry
		user = User.find_by(:email => params[:email])
		#binding.pry
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			#binding.pry

		redirect to 'properties'
		elsif user == nil
			redirect to '/signup'
		else
			"incorrect password!"
			redirect to '/login'
		end

	end

	get '/logout' do
		if logged_in?
			session.destroy
		end
		redirect to '/'
	end

end