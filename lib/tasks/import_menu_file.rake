desc "Import a JSON file into the DB"
task import_menu_file: :environment do
  unless ENV['FILE'].present?
    puts "No file was provided to import. You can do so by running 'rails import_menu_file FILE=<filepath>'"
    exit
  end

  importer = FileImporter.new(ENV['FILE'])
  log = importer.import

  puts "Import complete.\n#{log.join("\n")}"
end