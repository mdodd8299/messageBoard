require 'bundler'
Bundler.require

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/main.db')
require './models.rb'

use Rack::Session::Cookie, :key => 'rack.session',
    :expire_after => 2592000,
    :secret => SecureRandom.hex(64)

get '/' do
  redirect '/signUp'
end

get '/signIn' do
  erb :signIn

end

post '/user/create' do


  if params[:username] == "" || params[:password] == "" || params[:conPassword] == ""

    redirect '/'
  else
    if params[:conPassword] == params[:password]

    u = User.new
    u.username = params[:username]
    passBcrypt = BCrypt::Password.create(params[:password])
    u.password = passBcrypt
    u.date = Date.today
    u.save

    session[:id] = u.id

    redirect '/topics'
    else
      puts "Failure"
      puts "Failure"
      puts "Failure"

      redirect '/'
    end
  end

end

post '/user/signIn' do
  u = User.first(:username => params[:username])


  if u
    passUnBCrypt = u.password
    if BCrypt::Password.new(passUnBCrypt) == params[:password]
      session[:id] = u.id

      redirect '/topics'
    else
      redirect 'signUp'
    end
  else
    redirect 'signUp'
  end
end

get '/signUp' do
  u = session[:id]

  if u
    redirect '/topics'
  else
    erb :signUp
  end

end

get '/topics' do
  u = session[:id]

  if u
    @number = []
    @topics = []
    @topics = Topic.all
    @topics.each do |topic|
      @posts = []
      @posts = topic.posts
      @number.push(@posts.length)
    end
    @user = User.first(:id => session[:id])
    erb :topicsList
  else
    redirect '/'
  end
end

post '/thread/create' do

  if params[:name] == "" || params[:des] == ""
    redirect '/topics'
  else
    t = Topic.new
    t.name = params[:name]
    t.des = params[:des]
    t.save

    redirect '/topics'
  end
end

get '/signOut' do
  session.clear

  redirect '/signUp'
end

get '/thread/:id' do
  u = session[:id]
  if u
    @topic = Topic.first(:id => params[:id])
    @posts = @topic.posts

    puts session[:id]


    @user = session[:id]
    @u = User.first(:id => @user)

    erb :postList
  else
    redirect '/'
  end
end

post '/post/create/:t_id' do

  if params[:content] == ""
    redirect '/thread/' + params[:t_id]
  else
    p = Post.new
    p.content = params[:content]
    p.user_id = session[:id]
    p.topic_id = params[:t_id]
    p.time = Time.now
    p.save

    redirect '/thread/' + params[:t_id]
  end
end

get '/thread/:t_id/post/:id/edit' do
  @post = Post.first(:id => params[:id])
  @threadID = params[:t_id]

  erb :editPost
end

post '/thread/:t_id/post/:id/update' do
  p = Post.first(:id => params[:id])
  puts params[:newContent]
  p.content = params[:newContent]
  p.save

  thread = p.topic_id

  t = Topic.first(:id => thread)
  @topic = t.id
  t.save

  redirect '/thread/' + params[:t_id]
end

post '/thread/:id/delete' do
  t = Topic.where(:id => params[:id])
  t.destroy

  redirect '/topics'
end

get '/users' do
  @users = []

  u = session[:id]
  if u
    @u = session[:id]

    @users = User.all



    erb :userList
  else
    redirect '/'
  end
end

get '/users/:id' do
  @u = User.first(:id => params[:id])
  @posts = Post.where(:user_id => @u.id)

  erb :usersPost
end

get '/thread/:t_id/post/:post_id/delete' do
  p = Post.first(:id => params[:post_id])
  p.destroy

  redirect '/thread/' + params[:t_id]
end

post '/user/search' do
  u = User.first(:username => params[:username])

  if u
    redirect '/users/' + u.id.to_s
  else
    redirect 'users'
  end
end