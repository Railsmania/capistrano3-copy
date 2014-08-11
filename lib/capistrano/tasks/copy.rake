require 'zip'
require 'tempfile'

Zip.setup do |c|
  c.unicode_names = true
  c.on_exists_proc = true
  c.continue_on_exists_proc = true
end

TMP_COPY_DIR = '/tmp'
FILENAME = 'release.zip'

namespace :copy do

  # The name of the file we create locally prior to send it to the server.
  def release_local_file
    @release_local_file ||= fetch(:copy_local_file) || FILENAME
  end

  # All the project files we are gonna pack and send to the server.
  def all_project_files
    exclusions = fetch(:copy_exclude) || /\.log$/
    files = FileList['**/*']
    files.exclude(*exclusions).each do |file|
      yield file
    end
  end

  # check in each strategy is used to do checks on remote servers.
  # We do not need to do anything for this strategy
  task :check do

  end

  # called by Capistrano. Returns a string with current date and time
  task :set_current_revision do
    run_locally do
      set :current_revision,  Time.now.strftime("%Y%m%d%H%M%S")
    end
  end

  # This is the entry point of a strategy for Capistrano, capistrano will call
  # this task first
  task :create_release do |t|
    invoke 'copy:pack_release'
    uploaded_file = "#{TMP_COPY_DIR}/release.zip"
     on release_roles :all do
       execute :mkdir, "-p", TMP_COPY_DIR
       upload! release_local_file, TMP_COPY_DIR
       execute :unzip, '-o', uploaded_file, '-d', release_path
     end
     # We do not need the local file anymore
     run_locally do
       execute :rm, "-f", release_local_file
     end
  end

  # Task that gets all our software and pack it together
  task :pack_release do
    release_filename = release_local_file
    Dir.chdir '.' do
      Zip::File.open(release_local_file, Zip::File::CREATE) do |zipfile|
        all_project_files do |file|
          zipfile.add(file, file)
        end
      end
    end
  end

end
