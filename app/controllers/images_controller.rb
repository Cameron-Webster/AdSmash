class ImagesController < ApplicationController
  def index
    @images = Images.where('project_id = ?', params[:id])
  end

  def new
    @project= Project.find(params[:project_id])
    @image = Image.new


  end

  def create

     @image = Image.new(image_params)
     @image.project_id = params[:project_id]
     if @image.save
      redirect_to project_path(@image.project_id)
     else
      redirect_to new_project_image_path(@image.project_id), alert: 'Image upload unsuccessful please try again.'
     end
  end


  def destroy
    @image = Image.find(params[:project_id])
    @image.destroy
    redirect_to project_path(params[:id])
  end
  private

  def image_params
  params.require(:image).permit(:photo, :photo_cache)
end
end
