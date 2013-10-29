task :prepare do
  desc 'Prepare git submodule directories for pushing.'
  sh 'git submodule init'
  sh 'git submodule update'
end
task :bundle_gems do
  desc 'Use bundler standalone to prepare local gems for this checkout. Requires Bundler 1.3+'
  sh 'bundle install --standalone'
end
