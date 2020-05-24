class FoldersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

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
end
