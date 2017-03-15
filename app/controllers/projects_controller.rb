class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy,:add_users,:invite_view_users]
  before_action :new_project, only: [:new,:index]

  def index

    @notifications = Notification.where(recipient: current_user).unread

    @projects = current_user.projects
    if params[:filter]
      if params[:filter] == "live"
        @projects = @projects.where("status LIKE ?", "live")
      elsif params[:filter] == "closed"
        @projects = @projects.where("status LIKE ?", "closed")
      else
        search_people_list(params[:filter])
      end
    end

    search_content
    search_people
    search_date
    list_colleagues
  end




  def show

    @list = @project.users

    @project_images = @project.images.sort {|x, y| y[:created_at] <=> x[:created_at]}

    url = "http://static.giantbomb.com/uploads/original/9/99864/2419866-nes_console_set.png"

    if @project_images


      @first_image = params[:display_image].present? ? Image.find(params[:display_image]) : @project_images.first


    else

     Image.create(project_id: @project.id, remote_photo_url: 'http://apod.nasa.gov/apod/image/1407/m31_bers_960.jpg')

    @first_image = Image.last


    end
  end


  def new
  end


  def edit
    if params[:search]
      @users = User.where("lower(email) ILIKE ?", "%#{params[:search]}%")
    end
  end


  def create
    @project = Project.new(proj_params)
    @project.status="live"
    respond_to do |format|
      if @project.save
        project_link = ProjectTeam.new(user_id: current_user.id, project_id: @project.id, admin: true)
        if project_link.save
          Image.new(project_id: @project.id, photo: 'images/placeholder.jpg')
          format.html { redirect_to invite_users_path(@project)}
        end
      else
          format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(proj_params)
        format.html {

          if params[:step] == "3"
            redirect_to edit_project_path(@project, step: 2)


          elsif params[:step] == "2"
            redirect_to edit_project_path(@project, step: 3) , notice: "Project #{@project.name} was successfully created."



          elsif params[:step] == "3"
            redirect_to @project
          else
            redirect_to projects_path
          end

        }

      else
        format.html { render :edit }

      end
    end
  end


  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }

    end
  end

  def invite

    @search_term = params[:search]
    @project = params[:id]

    if @search_term.match(/@/).present?
        @users = User.where('email = ?', @search_term)

    else

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


  def search_content
    unless params["global_search"].nil?
      @projects = @projects.global_search params['global_search']['content']
    end
  end

  def search_people
     unless params["search_people"].nil?
      query = params[:search_people][:people].downcase || params[format]
      list = []
      @projects.each do |project|
        list << project if project.users.any? { |user| user.name == query || user.last_name == query || user.email == query }
      end
      @projects = list
    end
  end

    def search_people_list(query)
      list = []
      @projects.each do |project|
        list << project if project.users.any? { |user| user.name == query || user.last_name == query || user.email == query }
      end
      @projects = list

  end


  def search_date
    unless params["daterange"].nil?
      unless  params[:daterange].empty?
        @dates = datepicker_into_object(params[:daterange])
        @projects = @projects.where("deadline > ? AND deadline < ?", @dates[0] , @dates[1])
      end
    end
  end


  def list_colleagues
    @users_list = []


    unless current_user.projects.empty?

      current_user.projects.each do |project|
        @users_list << project.users
        @users_list2 = @users_list.flatten(1)
      end
      @colleagues_names = []
      @users_list2.each do |user|
         @colleagues_names << [user.name, user.last_name].join(" ") if user != current_user
      end
      @colleagues_names.uniq!
    end
  end
  def invite_view_users
    if params[:search]
      @users = User.where("lower(email) ILIKE ?", "%#{params[:search]}%")
    end
  end

  private
    def new_project
        if params[:project_id].present?
          @project = Project.find(params[:project_id])
        else
          @project = Project.new
        end
    end
    def set_project
      @project = Project.find(params[:id])
    end


    def proj_params
       params.require(:project).permit(:name, :brief, :target, :requirement, :position, :purpose, :brand, :deadline, :ad_networks, :status)
    end

    def datepicker_into_object(dates)
     dates.split("-").map{|date| Date.strptime(date.strip,"%m/%d/%Y")}
    end
end







