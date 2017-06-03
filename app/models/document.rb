class Document < ActiveRecord::Base
end

# db/migrate/20140602005921_create_documents.rb
class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :filename
      t.string :content_type
      t.binary :file_contents

      t.timestamps
    end
    def initialize(params = {})
  file = params.delete(:file)
  super
  if file
    self.filename = sanitize_filename(file.original_filename)
    self.content_type = file.content_type
    self.file_contents = file.read
  end
end
private
  def sanitize_filename(filename)
    # Get only the filename, not the whole path (for IE)
    # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
    return File.basename(filename)
  end
  end
end
