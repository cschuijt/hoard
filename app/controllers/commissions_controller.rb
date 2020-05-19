class CommissionsController < ApplicationController
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
    redirect_to 'index'
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
      params.require(:commission).permit(:title, :description, :started,
                                         :finished, :started_at, :finished_at,
                                          files: [])
    end
end
