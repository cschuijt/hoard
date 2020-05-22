class CommissionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user,       except: [:index, :show, :new, :create]
  before_action :private_filter,     only:    :show

  def index
    @commissions = Commission.all
  end

  def show
    @c = Commission.find(params[:id])
  end

  def new
    @commission = Commission.new
  end

  def create
    @commission = Commission.new(commission_params)
    @commission.user = current_user

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
