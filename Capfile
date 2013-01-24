#!/usr/bin/env ruby
# Capistrano script to populate a fresh shell with my personal configuration
# files and tools.

require 'rubygems'
require 'capistrano'
require 'find'

# Allocate PTYs on connecting
default_run_options[:pty] = true

set :repo_dir, File.dirname(__FILE__)
$: << '.' unless $:.include?('.')
libdir = File.join(fetch(:repo_dir), 'lib')
$: << libdir unless $:.include?(libdir)

# Load all capistrano configuration under config/deploy/
Dir["#{fetch(:repo_dir)}/config/*.rb"].each { |file| load(file) }

set :application, "jof's dotfiles"
set :user, ENV['USER']
set :deploy_to, '/Users/jof'

desc "Deploy to the local host"
task :localhost do
  role :server, "localhost"
end

# "Set ~/.ssh permissions."
task :set_ssh_permissions do
  dot_ssh = File.join(fetch(:deploy_to), '.ssh')
  run("mkdir -p #{dot_ssh}")
  run("find \"#{dot_ssh}\" -maxdepth 1 -type f -exec chmod 0600 {} \\;")
  run("find \"#{dot_ssh}\" -maxdepth 1 -type d -exec chmod 0700 {} \\;")
  run("chmod 0755 #{dot_ssh}")
  authorized_keys = File.join(dot_ssh, "authorized_keys")
  run("[ -f #{authorized_keys} ] && chmod 0644 #{authorized_keys}")
end


desc "Load up a home directory with personal options and tools."
task :deploy do |config|
  role(:server, hostname) if config[:hostname] 

  # Enumerate local files to place
  # Place local files into remote deploy_to path
  # Place SSH keys (work vs. personal? Submodule for work?)
  local_file_root = File.join(fetch(:repo_dir), "homedir_root")
  local_files = []
  local_directories = []
  Find.find(local_file_root) do |pathname|
    next if pathname.match(/\/\.git(\/|$)/) # Skip any .git directories
    local_directories << pathname if File.directory?(pathname)
    local_files << pathname if File.file?(pathname)
  end
  local_files.sort!
  local_directories.sort!

  # Figure out the remote home directory and upload everything relative to there
  # First, creating directories, and then filling them with files.
  remote_home_directory = capture("echo ${HOME}").strip
  local_directories.each do |directory_name|
    relative_path = directory_name.sub(local_file_root, '')
    remote_directory_path = File.expand_path(File.join(remote_home_directory, relative_path))
    run "mkdir -p #{remote_directory_path}"
  end
  local_files.each do |filename|
    relative_path = filename.sub(local_file_root, '')
    remote_file_name = File.expand_path(File.join(remote_home_directory, relative_path))
    upload(filename, remote_file_name, :via => :scp)
  end

  set_ssh_permissions
end
