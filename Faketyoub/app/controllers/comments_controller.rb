class CommentsController < ApplicationController 
    post '/comments' do 
       if 
           logged_in? 
            time = Time.new
            if params[:content] !=""
                comments = Comment.create(content: params[:content], date: time   , user_id:  params[:user_id],video_id: params[:video_id])
             end
        redirect '/videos'
    
       else 
        redirect '/signup'
       end
    end 
end
