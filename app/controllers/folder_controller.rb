require 'zip'

class FolderController < ApplicationController
  def create
    file = Folder.create(file_params)
    file.files.attach(params[:files])
    render :json => {
      :status => true
    }
  end

  def download
    folder = Folder.last
    file = folder.files.first
    file_name = file.filename.to_s
    binary = file.download
    send_data binary, type: 'image/jpeg', filename: file_name
  end

  def get_all
    folder = Folder.find(1)
    filezip = 'attachment.zip'
    temp_file = Tempfile.new(filezip)
    begin
      Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
        folder.files.each do |file|
          name = file.filename.to_s
          File.open(File.join(temp_file.read, name), 'wb') {|x| file.download {|chunk| x.write(chunk)}}
          zip.add(name, File.join(temp_file.read, name))
        end
      end
      zip_data = File.read(temp_file)
      send_data(zip_data, type: 'application/zip', disposition: 'attachment', filename: filezip)
    ensure 
      temp_file.close
      temp_file.unlink
    end
  end

  private
  def file_params
    params.require(:file).permit(:name)
  end
end
