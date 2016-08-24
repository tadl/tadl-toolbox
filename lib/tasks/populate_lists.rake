desc "populate lists with items manually"
task :populate_lists => :environment do
    lists = List.all
    lists.each do |l|
        l.check_url
    end
end