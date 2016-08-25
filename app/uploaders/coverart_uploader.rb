class CoverartUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    ENV['MOUNT_POINT']+'jacket/original/r'
  end

  def filename
    set_filename(model.id)
  end

  def set_filename(model_id)
    cover = Cover.find(model_id) rescue Cover.new
    return cover.record_id.to_s
  end 

  version :large do
    process :resize_to_limit => [nil, 400]
    process :convert => 'jpg'
    def full_filename (for_file = model.coverart.file) 
      set_filename(model.id)
    end 
    def store_dir
       ENV['MOUNT_POINT']+'jacket/large/r'
    end
  end

  version :medium do
    process :resize_to_limit => [nil, 200]
    process :convert => 'jpg'
    def full_filename (for_file = model.coverart.file) 
      set_filename(model.id)
    end 
    def store_dir
       ENV['MOUNT_POINT']+'jacket/medium/r'
    end
  end

  version :small do
    process :resize_to_limit => [nil, 100]
    process :convert => 'jpg'
    def full_filename (for_file = model.coverart.file) 
      set_filename(model.id)
    end 
    def store_dir
       ENV['MOUNT_POINT']+'jacket/small/r'
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  before :cache, :capture_size_before_cache # callback, example here: http://goo.gl/9VGHI
  def capture_size_before_cache(new_file) 
    if model.coverart_upload_width.nil? || model.coverart_upload_height.nil?
      model.coverart_upload_width, model.coverart_upload_height = `identify -format "%wx %h" #{new_file.path}`.split(/x/).map { |dim| dim.to_i }
    end
  end
end
