class ShakespeareAnalyzer
  include ActiveModel::Model

  attr_reader :totals, :speakers
  attr_accessor :url

  # adjusted code versus part 1 to avoid getting a blank url on initializing when navigating to "new" view

  def initialize(attributes = {})
    super
    @totals = Hash.new
    @speakers = Array.new
  end

  def get_speakers(url)
     xml_doc = Nokogiri::XML(open(url))
     xml_doc.xpath("//SPEECH/SPEAKER").each do |speaker|
       if @speakers.length == 0 || !@speakers.include?("#{speaker.text}")
          @speakers << speaker.text
       end
     end
     return @speakers
  end

  def parse_count_sort(speakers, url)
    xml_doc = Nokogiri::XML(open(url))
    speakers.each do |character|
      count = 0
      xml_doc.xpath("//SPEECH[SPEAKER[text() = '#{character}']]/LINE").each do |line|
          count += 1
      end
      if character != "ALL"
        @totals["#{character.upcase}"] = count
      end
    end

    return @totals.sort_by { |char, count| count}.reverse
  end

end
