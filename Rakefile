task :default => [:update, :config_link, :bundles ]

task :update do
  sh 'git pull'
  sh 'git submodule sync'
end

task :config_link do
  %w(vimrc).each do |file|
    dotfile = File.join(ENV['HOME'],".#{file}")
    fullname =  File.join(Dir.pwd,file)
    puts fullname
    if File.exist? dotfile
      warn "file #{dotfile} already exist"
      rm dotfile
    end
    ln_s fullname,dotfile
  end
end

task :bundles do
  dotfile = File.join(ENV['HOME'],'.vim')
  rm_rf dotfile if File.exist?(dotfile) || Dir.exist?(dotfile)
  ln_s Dir.pwd, dotfile
end
