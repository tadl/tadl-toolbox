class PatronPicUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    ENV['MOUNT_POINT']+'patronpics/'
  end

  def filename
    set_filename(model.id)
  end

  def set_filename(model_id)
    patron = Patron.find(model_id) rescue Patron.new
    return patron.id.to_s + rand(10 ** 20).to_s.rjust(10,'0') +'.jpg'
  end


  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  version :original do
    process :convert => 'jpg'
    def full_filename (for_file = model.patronpic.file) 
      set_filename(model.id)
    end 
    def store_dir
       ENV['MOUNT_POINT']+'patronpics/original'
    end
  end


  version :large do
    process :resize_to_limit => [nil, 800]
    process :convert => 'jpg'
    def full_filename (for_file = model.partonpic.file) 
      set_filename(model.id)
    end 
    def store_dir
       ENV['MOUNT_POINT']+'patronpics/large'
    end
  end

  version :small do
    process :resize_to_limit => [nil, 300]
    process :convert => 'jpg'
    def full_filename (for_file = model.patronpic.file) 
      set_filename(model.id)
    end 
    def store_dir
       ENV['MOUNT_POINT']+'patronpics/small'
    end
  end

end