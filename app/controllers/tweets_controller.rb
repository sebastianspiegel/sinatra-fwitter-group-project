class TweetsController < ApplicationController

    get '/tweets' do
        redirect_if_not_logged_in
        @tweets = Tweet.all 
        @user = User.find(session[:user_id])
        erb :'/tweets/index'
    end

    get '/tweets/new' do
        redirect_if_not_logged_in
        @user = User.find(session[:user_id])
        erb :'tweets/new'
    
    end

    get '/tweets/:id' do
        redirect_if_not_logged_in
        @tweet = Tweet.find(params[:id])
        erb :"tweets/show_tweet"
    end 

    post '/tweets' do
        tweet = Tweet.new 
        if params[:content].blank?
            redirect "/tweets/new"
        else
            tweet.content = params[:content]
            tweet.user = User.find(session[:user_id])
            tweet.save 
            redirect '/tweets'
        end
    end

    get '/tweets/:id/edit' do
        redirect_if_not_logged_in
        @tweet = Tweet.find(params[:id])
        if @tweet.user.id == session[:user_id]
            erb :"/tweets/edit"
        else
            redirect '/tweets'
        end
    end

    post '/tweets/:id' do
        redirect_if_not_logged_in
        tweet = Tweet.find(params[:id])
        if params[:content].blank?
            redirect "tweets/#{tweet.id}"
        else
            tweet.update(params)
            redirect "/tweets/#{tweet.id}"
        end
    end

    delete '/tweets/:id/delete' do
        redirect_if_not_logged_in
        tweet = Tweet.find(params[:id])
        tweet.delete
        redirect "/tweets"
    end

end
