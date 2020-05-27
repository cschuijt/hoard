class CommissionsController < ApplicationController
  before_action :authenticate_user!, except: [:show                       ]
  before_action :correct_user,       except: [:index, :show, :new, :create]
  before_action :private_filter,     only:   [:show                       ]

  def index
    @commissions = current_user.commissions
  end

  def show
    if params[:folder_id]
      @c = Folder.find(params[:folder_id]).commissions.find(params[:id])
    else
      @c = Commission.find(params[:id])
    end
  end

  def new
    @commission = current_user.commissions.new
  end

  def create
    @commission = current_user.commissions.new(commission_params)

    if @commission.valid?
      @commission.save
      redirect_to @commission
    else
      render 'new'
    end
  end

  def edit
    @commission = Commission.find(params[:id])
  end

  def update
    @commission = Commission.find(params[:id])

    if @commission.update(commission_params)
      redirect_to @commission
    else
      render 'edit'
    end
  end

  def destroy
    Commission.find(params[:id]).destroy
    redirect_to commissions_url
  end

  # Starting and finishing methods
  def start
    @c = Commission.find(params[:id])
    if @c.start
      flash[:notice] = @c.title + " has been marked as started."
    else
      flash[:error] = @c.title + " has already been started."
    end

    redirect_to @c
  end

  def finish
    @c = Commission.find(params[:id])
    if @c.finish
      flash[:notice] = @c.title + " has been marked as finished."
    else
      flash[:error] = @c.title + " has already been finished."
    end

    redirect_to @c
  end


  # Adding to and removing from folders
  def add_to_folder
    @f = Folder.find(params[:folder_id])
    @c = Commission.find(params[:id])

    @f.commissions << @c
    redirect_to @f
  end

  def remove_from_folder
    @f = Folder.find(params[:folder_id])
    @c = @f.commissions.find(params[:id])

    @f.commissions.delete @c
    redirect_to @f
  end

  # File uploads
  def upload_file
    @commission = Commission.find(params[:id])
    @commission.files.attach(params[:files])

    redirect_to @commission
  end

  def delete_file
    @file = ActiveStorage::Attachment.find(params[:id])
    @commission = Commission.find(@file.record_id)

    @file.purge
    redirect_to @commission
  end

  private
    def commission_params
      params.require(:commission).permit(:title,    :description, :started,
                                         :finished, :started_at,  :finished_at,
                                         :private,   files: [])
    end

    def correct_user
      @commission = current_user.commissions.find_by(id: params[:id])
      if @commission.nil?
        flash[:warning] = "You are not authorized to perform this action."
        redirect_to root_url
      end
    end

    def private_filter
      @commission = Commission.find(params[:id])

      if @commission.private?
        unless user_signed_in? && current_user == @commission.user
          flash[:warning] = "This commission is marked private, only the uploader can access it."
          redirect_to commissions_url
        end
      end
    end
end
