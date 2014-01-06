require 'sinatra'
require 'net/http'

  get "/" do 
    @title = "Tell someone to eat a bag of dicks"
    @url =  "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}/hey/Henry/rotate/Phillip"
    @base = "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    erb :"/index"
  end

  get "/api/console" do
    @title = "Use the console"   
    erb :"/api/console"
  end

  get "/api/response" do
    @to = params[:to]
    @verb = params[:verb]
    @from = params[:from]
    @url =  "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}/hey/#{@to}/#{@verb}/#{@from}"
    @url = @url.gsub(" ", "%20")
    erb :"/api/response"
  end  
  

  get "/hey/:to/:verb/:from" do
    @from = params[:from]
    @to = params[:to]
    @verb = params[:verb]
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
