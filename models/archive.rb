require 'nokogiri'
class Archive
  attr_reader :letters

  def initialize
    @letters = build_library
  end

  def build_library
    letters = []
    Dir.each_child('letters/may_i_recommend') do |letter|
      letters << ArchiveLetter.new("letters/may_i_recommend/#{letter}")
    end
    letters.sort_by { |l| l.index }
  end
end

class ArchiveLetter
  attr_reader :index, :title, :html
  def initialize(filename)
    @index = filename[24..25].to_i - 1
    @html, @title = parse(filename)
  end

  def parse(filename)
    page = ::Nokogiri::HTML.parse(File.read(filename))
    table = page.css('table')[1].to_s
    title = page.css('title').text[18..]

    return table, title
  end
end

ARCHIVE = Archive.new
