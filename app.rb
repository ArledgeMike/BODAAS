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
    @to = params[:to]
    @verb = params[:verb]
    @from = params[:from]
    @url =  short_url  url << "hey/#{@to}/#{@verb}/#{@from}"
    erb :"/api/response"
  end  
  

  get "/hey/:to/:verb/:from" do
    @title ="Hey #{@to}, go #{@verb} a bag of dicks. -from #{@from}"
    @from = params[:from]
    @to = params[:to]
    @verb = params[:verb]
    @url =  short_url  url << "hey/#{@to}/#{@verb}/#{@from}"
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
    @url = url.gsub(" ", "%20")
    authorize = UrlShortener::Authorize.new "o_1ajhsae040", "R_d236112c68ed3a20800cf2f69088f3e2"
    client = UrlShortener::Client.new authorize
    shorten = client.shorten(@url).shortUrl 
    @url = shorten
  end
  
  
  def url 
   # @base = "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    @base = "#{request.env['rack.url_scheme']}:/"

  end
  