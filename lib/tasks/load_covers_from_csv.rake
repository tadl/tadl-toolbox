desc "Expire and regenerate cache"
task :records_from_txt => :environment do
  require 'csv'
  require 'open-uri'
  require 'json'
    CSV.foreach("#{Rails.root}/db/bibs.csv") do |x|
      puts x
      url = 'http://mr-v2.catalog.tadl.org/osrf-gateway-v1?service=open-ils.search&method=open-ils.search.biblio.record.mods_slim.retrieve&locale=en-US&param=' + x.to_s
      record_info = JSON.parse(open(url).read)
      record_info["payload"].each do |z|
        cover = Cover.new
        test = cover.check_for_cover(z[0]['__p'][2])
        if test == true
          puts z[0]['__p'][0] + ' has a cover'
        else
          puts z[0]['__p'][0] + ' has no cover'
          cover.record_id = z[0]['__p'][2]
          cover.title = z[0]['__p'][0]
          cover.artist = z[0]['__p'][1]
          cover.publisher = z[0]['__p'][6]
          cover.release_date = z[0]['__p'][4]
          cover.item_type = z[0]['__p'][9][0]
          cover.track_list = z[0]['__p'][15]
          cover.abstract = z[0]['__p'][13]
          cover.status = "needs cover"
          if cover.valid? == true
            cover.save!
          end
        end
      end
    end
end