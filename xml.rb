require 'active_support/all'

xml = File.open("sales_data.xml")
doc = Hash.from_xml(xml)

puts guid = doc['Root']['FileAttribute']['GUID']
puts ''
puts batch = doc['Root']['FileData']['Batch'] if batch.is_a? Hash
