desc "copy data to seed file"
  task :copy_data => :environment do
    Game.all.each do |g|
      puts "Game.create(#{g.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
