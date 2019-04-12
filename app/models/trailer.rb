class Trailer < ActiveRecord::Base
  validates_uniqueness_of :record_id
  belongs_to :admin

  def set_attributes(record_id)
    url = 'http://mr-v2.catalog.tadl.org/osrf-gateway-v1?service=open-ils.search&method=open-ils.search.biblio.record.mods_slim.retrieve&locale=en-US&param='
    request = JSON.parse(open(url + record_id).read)
    if !request['payload'][0]['desc']
      self.title = request['payload'][0]['__p'][0]
      self.artist = request['payload'][0]['__p'][1]
      self.record_id = request['payload'][0]['__p'][2]
      self.release_date = request['payload'][0]['__p'][4]
      self.abstract =   request['payload'][0]['__p'][13]
      self.publisher = request['payload'][0]['__p'][6]
      self.item_type = request['payload'][0]['__p'][9][0]
      self.track_list = request['payload'][0]['__p'][15]
      if self.valid? == true
        self.save!
        return "success"
      else
        return "Not a valid record id"
      end
    else
      return "Not a valid record id"
    end
  end
end