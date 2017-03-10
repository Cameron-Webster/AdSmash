class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]


  def index

      @notifications = Notification.where(recipient: current_user).unread


    @projects = current_user.projects

    unless params["global_search"].nil?
      @projects = @projects.global_search params['global_search']['content']
    end

    unless params["search_people"].nil?
      query = params[:search_people][:people].downcase
      list = []
      @projects.each do |project|
        list << project if project.users.any? { |user| user.name == query || user.last_name == query || user.email == query }
      end
      @projects = list
    end
      # (User.global_search "bailey_ernser@effertz.net")[0].projects

    unless params["daterange"].nil?
      unless  params[:daterange].empty?
        @dates = datepicker_into_object(params[:daterange])
        @projects = @projects.where("deadline > ? AND deadline < ?", @dates[0] , @dates[1])
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
          Image.new(project_id: @project.id, photo: 'images/placeholder.jpg')
          format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        end
      else
          format.html { render :new }
      end
    end
  end

  def show
    @comment = Comment.new
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

  def invite

    @search_term = params[:search]

    @project = params[:id]

    if @search_term.match(/@/).present?
      @users = User.where('email = ?', @search_term)
    else
      search = @search_term.split(' ')
       @users = User.where('name = ? and last_name = ?', search[0], search[1])
    end

  end

  def invite_existing

    project_link = ProjectTeam.new(project_id: params[:id], user_id: params[:user])

    if project_link.save
     redirect_to project_path(params[:id]), notice: 'User added to Project'
    else
      redirect_to project_path(params[:id]), alert: 'User not added to Project'
    end

  end

  def invite_send

      @project = params[:id]

      email = params[:search]

      TempUser.create(email: email, project_id: @project)

      UserMailer.invite(email, @project).deliver_now

      redirect_to project_path(@project), notice: 'invite sent'


  end




  private

    def set_project
      @project = Project.find(params[:id])
    end


    def project_params
       params.require(:project).permit(:name, :brief, :campaign_start, :campaign_end, :brand, :deadline, :ad_networks, :status)
    end

    def datepicker_into_object(dates)
     dates.split("-").map{|date| Date.strptime(date.strip,"%m/%d/%Y")}
    end
end







