require 'fileutils'
namespace :gem do
  desc "Build ThreadedProcessor"
  task :build do
    puts "\n= Building Gem."
    system("gem build threaded_processor.gemspec")
  end
  
  desc "Cleanup build gems"
  task :clean do
    puts "= Cleaning up gems"
    FileList.new("*.gem").each do |f|
      rm_rf f
    end
  end
end

namespace :rdoc do
  desc "Build docs"
  task :build do
    puts "\n= Building docs"
    system("rdoc README.rdoc ./")
  end
  
  desc "Cleanup docs"
  task :clean do
    puts "= Cleaning up docs"
    FileList.new('*.rid', 'doc/').each do |f|
      rm_rf f
    end
  end
end

desc "Cleanup"
task :clean do
  FileList.new("*.gem", '*.rid', 'doc/**/*').each do |f|
    rm_rf f
  end
end


desc "Build all"
task :build => ["gem:build", "rdoc:build"] do ; end

desc "Clean all"
task :clean => ["gem:clean", "rdoc:clean"] do ; end