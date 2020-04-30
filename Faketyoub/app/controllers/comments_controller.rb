class CommentsController < ApplicationController 
 post '/comments' do 
      if 
         logged_in?
         comments = Comment.create(content: params[:content], date: params[Date.today], user_id:  params[:user_id],video_id: params[:video_id])
         redirect '/videos'
       else 
         redirect '/signup'
       end
    end
end
