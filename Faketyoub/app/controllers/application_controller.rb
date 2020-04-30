class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    use Rack::Flash
    
    configure do
      #enabling sessions will give us acsess to session that is a hash
      enable :sessions
      set :session_secret, "faketyoube-1234" #extra layer of security 
      
      set :public_folder, 'public'
      set :views, 'app/views'
    end
  
    get "/" do
      if logged_in? 
        redirect "/users/#{current_user.id}"
      else

      erb :welcome
      end
    end

  helpers do 

    def logged_in?
      !!current_user
    end

    def current_user
      # User.find(session[:user_id]) return the user if there is one this however will error if it doesnt find a user 
      # instead we use find_by cause it returns nil and we wanna return nil if there is no user 
     @current_user ||= User.find_by(id: session[:user_id]) #returns user or nil ||= is syntactic sugar to help the database
     end
  end

  def not_empty?
    params[:name] != "" && params[:email] != "" && params[:password] != ""
  end

  def authorized_to_edit?(video)
     current_user == video.user
  end
end