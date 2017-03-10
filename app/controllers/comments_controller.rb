class CommentsController < ApplicationController
  before_action :set_image, only: [:create]
  before_action :set_project, only: [:index, :create]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index

    @comment = Comment.new
  end

  def new
    @comment = Comment.new
  end

  def create

    @comment = Comment.new(comment_params)
    @comment.image_id = params[:image_id]
    @comment.user_id = current_user.id
    @comment.likes = 0
    if @comment.save
      flash[:notice]  = 'Comment added'
       @project = Project.find(params[:project_id])

      @project.users.each do |user|
        Notification.create(recipient: user, actor: current_user, action: "posted", notifiable: @project)
      end
    else
      flash[:error]  = 'Comment not saved'
    end
    redirect_to project_path(@project)




    end



def destroy
end

private

def set_comment
  @comment = Comment.find(params[:id])
end

def set_image
  @image = Image.find(params[:image_id])
end

def set_project
  @project = Project.find(params[:project_id])
end

def comment_params
  params.require(:comment).permit(:content, :attachment)
end

end
