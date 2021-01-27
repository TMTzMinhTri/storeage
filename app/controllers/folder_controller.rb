class FolderController < ApplicationController
  def create
    file = Folder.create!(file_params)
    file.files.attach(params[:files])
    render :json => {
      :status => true
    }
  end

  def download
    file = Folder.last
    binary = file.files.first.download
  end

  def get_all
    folder = Folder.find(3)
    images = folder.files.map{|x| url_for(x)}
    render :json => {
      :status => true,
      :images => images
    }
  end

  private
    def file_params
      params.require(:file).permit(:name)
    end
end
