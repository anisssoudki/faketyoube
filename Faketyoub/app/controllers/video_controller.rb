class VideoController < ApplicationController

    get '/videos' do 
      @videos = Video.all 
      erb :'videos/index'
    end
  
  
    # renders form to upload video
       get '/videos/new' do 
        erb :'/videos/new'
       end
  
  
     get '/videos/:id' do 
      set_video
      
      if logged_in?

        erb :"videos/show"
      else 
        redirect '/signup'
      end
      # @video = Video.find(params[:id])
      # check database for new id value maybe erb an error page somehow?
  
      # @video.params[:id] == nil 
      #   flash[:message] = "the video was deleted"
      
     end
  
      # get 'videos/:id' do
        
      #   @video = Video.find(params[:id])
      #   if @video.user_id == @user.id 
      #   erb :"videos/show"
      #   else
      #     redirect 'users/login'
      #   end
      # end
    
  
       post '/videos' do 
        # raise params.inspect
        #only wanna save entry if there is a value 
        #only want to create video when a user is logged in
        if !logged_in?
          redirect '/'
        end
        if params[:name] !="" && params[:link] !=""
  
          @video = Video.create(name: params[:name], link: params[:link], user_id: current_user.id)
            redirect "videos/#{@video.id}"
        else
          redirect '/Videos/new'
        end
       end
  
  
    
  
        get '/videos/:id/edit' do 
          set_video
          if logged_in?
            if authorized_to_edit?(@video)
              erb :"videos/edit"
            else
              redirect "users/#{current_user.id}"
            end
          else
            redirect '/'
          end
        end
  
  
        patch '/videos/:id' do 
          set_video
          # binding.pry
          if logged_in? 
            if authorized_to_edit?(@video)
               @video.update({name: params[:name], link: params[:link]})
                redirect "/videos/#{@video.id}"
            else  redirect "users/#{current_user.id}"
            end
          else
            redirect '/'
          end
      end
  
      delete '/videos/:id' do 
      
        set_video
        if authorized_to_edit?(@video)
          @video.destroy
          redirect "users/#{@video.user.id}"
        else
          redirect 'users/login'
        end
  
      end
  
  
      private
  
      def set_video
      @video = Video.find(params[:id])
      end
  
   end
   
  