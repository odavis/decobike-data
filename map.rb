require 'nokogiri'
require 'open-uri'
require 'csv'
require 'pry'

#DecoBike Bike Data XML file http://www.decobike.com/playmoves.xml

#open xml data
doc = Nokogiri::XML(open("playmoves.xml")) do |config|
  config.strict.noblanks
end

#adds timestamps to each location when the data was lasted parsed
doc.search('location').each do |location|
  location.add_child("<Timestamp='>#{Time.now.to_s}</Object>")
end

#writes CSV file with parsed data
CSV.open("bikedata-#{Time.now}.csv", 'wb') do |csv|
  csv << doc.at('location').search('*').map(&:name)
  doc.search('location').each do |x|
    csv << x.search('*').map(&:text)
  end
end









