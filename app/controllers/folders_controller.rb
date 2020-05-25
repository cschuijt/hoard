class FoldersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :private_filter,     only:   [:show]
  before_action :correct_user,       except: [:index, :show, :new, :create]

  def index
    @folders = current_user.folders
  end

  def show
    @folder = Folder.find(params[:id])
  end

  def new
    @folder = current_user.folders.new
  end

  def create
    @folder = current_user.folders.new(folder_params)

    if @folder.save
      redirect_to @folder
    else
      render 'new'
    end
  end

  def edit
    @folder = Folder.find(params[:id])
  end

  def update
    @folder = Folder.find(params[:id])

    if @folder.update(folder_params)
      redirect_to @folder
    else
      render 'edit'
    end
  end

  def destroy
    Folder.find(params[:id]).destroy
    redirect_to folders_url
  end

  private
    def folder_params
      params.require(:folder).permit(:title, :description, :private)
    end

    def private_filter
      @folder = Folder.find(params[:id])

      if @folder.private?
        authenticate_user!

        unless current_user == @folder.user
          flash[:warning] = "This commission is marked private, only the uploader can access it."
          redirect_to folders_url
        end
      end
    end

    def correct_user
      @folder = current_user.folders.find_by(id: params[:id])
      if @folder.nil?
        flash[:warning] = "You are not authorized to perform this action."
        redirect_to folders_url
      end
    end
end
