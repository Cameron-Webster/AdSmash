class CommentsController < ApplicationController
  before_action :get_image, only: [:index]

  def index

    @comments = Comments.where('image_id = ?', @image.id)
  end

  def new

    @comment = Comment.new

  end

  def create

    @comment = Comment.new(comment_params)
     @comment.image_id = params[:image_id]
     @comment.user_id = current_user.id
     @comment.likes = 0
     raise
     if @comment.save
      redirect_to project_path(params[:project_id])
     else
      redirect_to project_path(params[:project_id]), alert: 'Comment unsuccessful please try again.'
     end
  end


  def destroy
  end

  private

  def get_image
    @image = Image.find(params[:image_id])
  end

  def comment_params
    params.require(:comment.permit(:content, :attachment)
  end
end
