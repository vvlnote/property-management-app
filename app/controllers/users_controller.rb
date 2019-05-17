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
			flash[:missing_pw_email] = "Please type in the password and email in order to complete sign up!"
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
		erb :'/users/login'
	end

	post '/login' do
		binding.pry
		user = User.find_by(:email => params[:email])
		binding.pry
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			binding.pry
		redirect to 'properties'
		elsif user == nil
			flash[:incorrect_login_name] = "#{params[:email]} is not recognized, please reenter the registered email, or go the the signup page!"
		else
			flash[:incorrect_password] = "Your password is not correct, please reenter it."
			binding.pry
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