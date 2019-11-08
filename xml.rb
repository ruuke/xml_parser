require 'active_support/all'

xml = File.open("sales_data.xml")
doc = Hash.from_xml(xml)

puts guid = doc['Root']['FileAttribute']['GUID']
puts ''

puts batch = doc['Root']['FileData']['Batch']
batch_id = batch['BatchID']
batch_creation_date = batch['CreationDate']

invoices = doc['Root']['FileData']['Invoice']
invoices.each do |invoice|
  invoice_operation = invoice['InvoiceOperation']
  puts company_code = invoice_operation['CompanyCode']
  puts invoice_operation_number = invoice_operation['InvoiceOperationNumber']
  puts invoice_operation_date = invoice_operation['InvoiceOperationDate']

  puts data = invoice['InvoiceData']

  invoice_data(data)
end

def invoice_data(data)
  data
end

invoice_data = invoices.each do |invoice|


