class UsersController < ApplicationController

	get '/signup' do
		binding.pry
	  	if !session[:user_id]
	  		users = User.all
			if users.all.size == 0
		 		@is_admin = true
				@user_name = "admin"
				@email = "admin@property_mg.com"
			else
				@is_admin = false
				@email_name = "manager_amy@property_mg.com"
			end
			erb :'/users/new'
		end
	end

	post '/signup' do
		binding.pry
		if params[:password] == ""
			#need to post an error message
			redirect to '/signup'
		end
		is_admin = false
		if params[:user_name] == "admin"
			is_admin = true
		else
			if params[:user_name] == ""
				params[:user_name] = params[:email]
			end
		end
		#binding.pry
		user = nil
		if is_admin
		user = User.new(:user_name => params[:user_name], :email => params[:email], 
			:password => params[:password], :is_admin => is_admin)
		else
			user = User.find_by(:email => params[:email])
			user.password = params[:password]
			user.is_admin = is_admin
		end
		user.save
		#binding.pry
		session[:user_id] = user.id
		session[:is_admin] = user.is_admin

		if is_admin
			redirect 'users/admin'
		else
			redirect 'properties'
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
			session[:is_admin] = user.is_admin
			#binding.pry
			if user.is_admin
				redirect to 'users/admin'
			end
		elsif user == nil
			redirect to '/signup'
		else
			"incorrect password!"
			redirect to '/login'
		end

	end

	get '/users/admin' do
		#binding.pry
		if logged_in? && is_admin?
			temp = User.all
			@property_managers = []
			temp.each do |user|
				if !user.is_admin
					@property_managers << user
				end
			end

			erb :'/users/admin'
		elsif !logged_in?
			redirect to '/login'
		else
			redirect to "/users/#{session[:user_id]}"
		end

	end

	get '/admin/managers/new' do
		redirect_if_not_logged_in
		if is_admin?
			@properties = Property.all
			binding.pry
			erb :'/users/new_pm'
		else

		end

	end

	post '/admin/managers' do
		binding.pry
		user = User.create(:email => params[:email], :is_admin => false)
		binding.pry
		user = User.find_by(:email => params[:email])
		binding.pry
		@managers = User.all
		binding.pry
		erb :'/users/managers'
	end

	get '/users/:id' do

	end

	get '/logout' do
		if logged_in?
			session.destroy
		end
		redirect to '/'
	end

end