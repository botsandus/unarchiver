require "zip"

class Unarchiver
  def self.temp_file(contents, name, extension)
    Tempfile.new([name, extension]).tap do |temp_file|
      temp_file.binmode
      temp_file.write(contents)
      temp_file.flush
      temp_file.rewind
    end
  end

  def initialize(file)
    @file = file
  end

  # The dataset importer supports ZIP files which contain multiple underlying
  # dataset files. This method will either return the original file if it is not
  # a ZIP file, or will expand the ZIP file and return each of the potential
  # dataset files included in it.
  def expand(valid_extensions: nil)
    return [] unless file

    if (extension = File.extname(file.path)) == ".zip"
      expand_zip(valid_extensions:)
    else
      # Ensure we're consistently returning an array of new tempfiles
      [self.class.temp_file(file.read, File.basename(file.path), extension)]
    end
  end

  private

  attr_reader :file

  # This is a ZIP upload, so expand it
  def expand_zip(valid_extensions: nil)
    Zip::File.open(file) do |zip_file|
      zip_file.each_with_object([]) do |entry, files|
        zip_entry = ZipEntry.new(entry, valid_extensions:)
        files << zip_entry.to_file if zip_entry.valid?
      end
    end
  end

  class ZipEntry
    def initialize(entry, valid_extensions: nil)
      @entry = entry
      @valid_extensions = valid_extensions
    end

    def valid?
      entry.file? && visible? && valid_extension?
    end

    # Create a temporary file and add it to the list of files. We need to
    # ensure we keep the extension so that the parser can determine the
    # correct file format; that's what the second argument to Tempfile.new
    # is for.
    def to_file
      Unarchiver.temp_file(read, entry.name, extension)
    end

    private

    attr_reader :entry, :valid_extensions

    def extension
      @extension ||= File.extname(entry.name)
    end

    def read
      entry.get_input_stream.read
    end

    def basename
      @basename ||= File.basename(entry.name, extension)
    end

    def visible?
      !basename.start_with?(".")
    end

    def valid_extension?
      return true if valid_extensions.nil?
      return true if valid_extensions.empty?

      valid_extensions.include?(extension[1..])
    end
  end
end
