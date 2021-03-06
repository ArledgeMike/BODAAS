require 'sinatra'
require 'net/http'
require 'rubygems'
require 'url_shortener'
 

  get "/" do 
    @title = "Tell someone to eat a bag of dicks"
    @url =  url
    erb :"/index"
  end

  get "/api/console" do
    @title = "Use the console to send a bag of dicks"   
    @url =   url  << "api/console"
    erb :"/api/console"
  end

  get "/api/response" do
    @title = "Copy and paste the short URL to a FB post or Tweet."
    @to = params[:to].capitalize
    @verb = params[:verb]
    @from = params[:from].capitalize
    @url =  url.gsub!("api/response", "hey")
    @url = short_url @url << "/#{@to}/#{@verb}/#{@from}"
    erb :"/api/response"
  end  
  

  get "/hey/:to/:verb/:from" do
    @from = params[:from].capitalize
    @to = params[:to].capitalize
    @verb = params[:verb]
    @title ="Hey #{@to}, go #{@verb} a bag of dicks. -from #{@from}"

    @url =  url 
    erb :"/hey"
  end



  helpers do 
    def title
      if @title
        @title
      else
       @title = "Bag Of Dicks As A Service"
      end
    end
    
    include Rack::Utils
    alias_method :h, :escape_html
    
  end

  private
  
  def short_url(url)
    @url = url.gsub(" ", "%20").gsub("api/resonse", "hey")
    authorize = UrlShortener::Authorize.new "[enter_bitly_id], [enter_bitly_api_key]"
    client = UrlShortener::Client.new authorize
    shorten = client.shorten(@url).shortUrl 
    @url = shorten
  end
  
  
  def url 
   # @base = "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    @base = "#{request.env}"

  end
  