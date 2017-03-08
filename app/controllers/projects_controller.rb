class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]


  def index
    @projects = Project.joins(:project_teams).where('project_teams.user_id = ?', current_user.id)

    unless params["search_bar"].nil?
      if params["search_bar"][:name]
        @projects = @projects.where("name LIKE ?", "%#{params["search_bar"][:name]}%")
      end
    end

    unless params["search_bar"].nil?
      if params["search_bar"][:brand]
        @projects = @projects.where("brand LIKE ?", "%#{params["search_bar"][:brand].downcase.titleize}%")

      end
    end

    unless params["search_bar"].nil?
      if params["search_bar"][:status]
        @projects = @projects.where("status LIKE ?", "%#{params["search_bar"][:status]}%")
      end
    end

     unless params["search_bar"].nil?
      if params["search_bar"][:email]
        @projects = User.find_by(email: params["search_bar"][:email]).projects
      end

    end



  end

  def show
  end


  def new
    @project = Project.new
  end


  def edit
  end


  def create
    @project = Project.new(project_params)


    respond_to do |format|
      if @project.save
        project_link = ProjectTeam.new(user_id: current_user.id, project_id: @project.id, admin: true)
        if project_link.save
        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        end
      else
        format.html { render :new }
      end
    end
  end

  def show

  end


  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end


    def project_params
       params.require(:project).permit(:name, :brief, :campaign_start, :campaign_end, :brand, :deadline, :ad_networks, :status)
    end
end







