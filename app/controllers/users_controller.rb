class UsersController < ApplicationController

    get '/login' do
        if logged_in?
            redirect '/tweets'
        else
            erb :"/users/login"
        end
    end

    get '/signup' do
        if session[:user_id]
            redirect '/tweets'
        else
            erb :"/users/signup"
        end
    end

    post '/login' do
        user = User.find_by_username(params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    post '/signup' do
        u = User.new(params)
        if u.email.blank? || u.password.blank? || u.username.blank? || User.find_by_email(params[:email]) || User.find_by_username(params[:username])
            redirect '/signup'
        else
            u.save 
            session[:user_id] = u.id
            redirect '/tweets'
        end
    end

    get '/logout' do
        if !logged_in?
            redirect '/'
        else
            erb :"/users/logout"
        end
    end

    post '/logout' do
        if logged_in?
            session.destroy
            redirect '/login'
        else
            redirect '/'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :"/users/show"
    end
 
end
