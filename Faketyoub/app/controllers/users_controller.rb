class UsersController < ApplicationController 


    #render the login page(form)
    get '/login' do 

        erb :'users/login'

    end 
    #the post method corresponds on the method on the form and the action
    #should match the route '/login' in this case  this is basically creating a session 
    #receive login form find user and log user in 

    post '/login' do 
        #find, authenticate, log the user in and redirect to user's landing page
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password]) && params !=nil #returns false when authentication fails and user itself when authetication is true
            #log in the user as in create a session
            session[:user_id] = @user.id #assign session hash equal to the users id 
            
                redirect "users/#{@user.id}"
        else
           
            erb :'/users/signup'
       
            flash[:mesage] = "your password or username is incorrect click back and sigup or login " 
            
        end
      
    end

    #this route's job is to render the signup form
    get '/signup' do 
       
        erb :'users/signup'
    end
    #only wanna persist a user that has all params filled 
    post '/users' do

        if params[:name] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
          
        else
           
            redirect '/signup'
           
        end

    end


#user show route
    get '/users/:id' do 
        @user = User.find_by(id: params[:id])
        erb :'/users/show'
    end


    get '/logout' do 
        session.clear
        redirect'/'
    end

end