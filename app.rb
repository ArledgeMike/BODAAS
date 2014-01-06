require 'sinatra'

  get "/" do 
    @title = "Tell someone to eat a bag of dicks"
    erb :"/index"
  end

  get "/apiconsole" do
    @title = "Use the console"   
    erb :"apiconsole"
  end

  get "/apipost" do
    @to = params[:to]
    @verb = params[:verb]
    @from = params[:from]
    @url = "localhost:4567/hey/#{@to}/#{@verb}/#{@from}/"
    @url = @url.gsub(" ", "%20")
    erb :"/hey"
  end  
  

  get "/hey/:to/:verb/:from" do
    @from = params[:from]
    @to = params[:to]
    @curse = params[:verb] 
    @url = "localhost:4567/hey/#{@to}/#{@curse}/#{@from}/"
    @url = @url.gsub(" ", "%20")
    erb :"/hey"
  end



  helpers do 
    def title
      if @title
        @title
      else
       @title = "EABOD API"
      end
    end
    
    include Rack::Utils
    alias_method :h, :escape_html
    
  end
