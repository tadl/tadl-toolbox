class Patron < ActiveRecord::Base
  mount_uploaders :patronpic, PatronPicUploader
end
