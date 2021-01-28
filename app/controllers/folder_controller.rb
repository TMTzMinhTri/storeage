require 'zip'

class FolderController < ApplicationController
  def create
    file = Folder.create!(file_params)
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
    input_filenames = []
    folder.files.each {|x| input_filenames << Folder.file_path(x)}

    filezip = 'attachment.zip'
    temp_file = Tempfile.new(filezip)
    p input_filenames
    # begin
    #   Zip::OutputStream.open(temp_file) { |zos| }

    #   Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
    #     folder.files.each do |image|
    #       zip.add(image, Rails.root.join('storage'))
    #     end
    #   end

    #   zip_data = File.read(temp_file.path)
    #   # send_data(zip_data, type: 'application/zip', disposition: 'attachment', filename: filezip)
    # ensure # important steps below
    #   temp_file.close
    #   temp_file.unlink
    # end

    # images = folder.files.map{|x| rails_blob_path(x, disposition: "attachment")}
    # files = save_files_on_server(folder.files)
    # zip_data = create_temporary_zip_file(files)
    # send_data(zip_data, type: 'application/zip', filename: 'user.zip')
    # render :json => {
    #   :status => true,
    #   :images => images
    # }
  end

  private
  def file_params
    params.require(:file).permit(:name)
  end

  def save_files_on_server(files)
    temp_folder = File.join(Dir.tmpdir, 'images')
    p temp_folder
    FileUtils.mkdir_p(temp_folder) unless Dir.exist?(temp_folder)

    files.map do |picture|
      file_name = picture.filename.to_s
      file_path = File.join temp_folder, file_name
      p '----------------------'
      p file_path
      p '----------------------'
      File.open(file_path, 'wb') {|f| f.write(picture.download)}
    end
  end

  def create_temporary_zip_file(filepaths)
    temp_file = Tempfile.new('user.zip')

    begin
      Zip::OutputStream.open(temp_file) { |zos| }
      Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
        filepaths.each do |filepath|
          filename = File.basename filepath
          # add file into the zip
          zip.add filename, filepath
        end
      end
      return File.read(temp_file.path)
    ensure
      temp_file.close
      temp_file.unlink
      filepaths.each { |filepath| FileUtils.rm(filepath) }
    end
  end
end
