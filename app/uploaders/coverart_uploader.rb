# encoding: utf-8

class CoverartUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  validate :validate_minimum_image_size

  def validate_minimum_image_size
    image = MiniMagick::Image.open(picture.path)
    unless image[:width] > 400 && image[:height] > 400
      errors.add :image, "should be 400x400px minimum!" 
    end
  end

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  def store_dir
    'jacket/orginal/r'
  end

  def filename
    set_filename(model.id)
  end

  def set_filename(model_id)
    cover = Cover.find(model_id)
    return cover.record_id.to_s
  end 

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :large do
    process :resize_to_limit => [nil, 400]
    process :convert => 'jpg'
    def full_filename (for_file = model.coverart.file) 
      set_filename(model.id)
    end 
    def store_dir
      'jacket/large/r'
    end
  end

  version :medium do
    process :resize_to_limit => [nil, 200]
    process :convert => 'jpg'
    def full_filename (for_file = model.coverart.file) 
      set_filename(model.id)
    end 
    def store_dir
      'jacket/medium/r'
    end
  end

  version :small do
    process :resize_to_limit => [nil, 100]
    process :convert => 'jpg'
    def full_filename (for_file = model.coverart.file) 
      set_filename(model.id)
    end 
    def store_dir
      'jacket/small/r'
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
