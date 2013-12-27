require 'sinatra'
require 'sinatra/activerecord'
require './enviroments'


class Post < ActiveRecord::Base 
end  
  get "/" do 
    @posts= Post.order("created_at DESC")
    @title = "Tell someone to eat a bag of dicks"
    erb :"post/index"
  end

  get "/post/eabod/:from/:to" do
    @from = params[:from]
    @to = params[:to]
    erb :"post/eabod"
  end


  helpers do 
    def title
      if @title
        "#{@title}"
      else
        "Welcome"
      end
    end
  end
