# aspirational

class Archive
  attr_reader :letters

  def initialize
    @letters = build_library
  end

  def build_library
    letters = []
    Dir.foreach('../letters/inlined')  do |letter|
      if letter != '.' && letter != '..'
        letters << ArchiveLetter.new("../letters/inlined/#{letter}")
      end
    end
    letters.sort_by { |l| l.title }
  end
end

class ArchiveLetter
  attr_reader :title, :html
  def initialize(filename)
    #TODO: make titles prettier
    @title = filename[19..20]
    @html = File.read(filename)
  end
end
