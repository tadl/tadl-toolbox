desc "export lists so that we can load them into new toolbox"
task :export_lists => :environment do
    lists = List.all
    lists.each do |l|
        admin = Admin.find(l.admin_id) rescue nil
        puts l.name + ',' + l.code + ',' + l.url + ',' + admin.uid + ',' + admin.name + ',' + l.created_at.to_s rescue ''
    end
end