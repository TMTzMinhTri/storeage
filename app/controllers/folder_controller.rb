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

  private
    def file_params
      params.require(:file).permit(:name, files:[])
    end
end
