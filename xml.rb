require 'active_support/all'

xml = File.open("sales_data1.xml")
doc = Hash.from_xml(xml)

puts guid = doc['Root']['FileAttribute']['GUID']
puts ''
puts batch = doc['Root']['FileData']['Batch']

