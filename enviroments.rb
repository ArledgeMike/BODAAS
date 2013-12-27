configure :development do 
	set :database, 'sqlite:///dev.db'
	set :show_exceptions, true
end

configure :production do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

	ActiveRecord::Base.establish_connection(
		:adapter => db.scheme == 'postrgres' ? 'postgresql' :db.scheme,
		:host => db.host,
		:username => db.user,
		:passsword => db.password,
		:database => db.path[1..-1],
		:encoding => 'utf8'
	)
end
