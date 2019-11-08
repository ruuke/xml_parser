class XmlParserService
  def self.call(batch)
    new(batch).call
  end

  def initialize(batch)
    @batch = batch
  end

  def call

  end

  def parse_data
    xml = File.open(@batch.file)

    doc = Hash.from_xml(xml)

    puts guid = doc['Root']['FileAttribute']['GUID']

    puts batch = doc['Root']['FileData']['Batch']
    batch_id = batch['BatchID']
    batch_creation_date = batch['CreationDate']

    invoices = doc['Root']['FileData']['Invoice']

    invoices.each do |invoice|
      invoice_operation = invoice['InvoiceOperation']
      puts company_code = invoice_operation['CompanyCode']
      puts invoice_operation_number = invoice_operation['InvoiceOperationNumber']
      puts invoice_operation_date = invoice_operation['InvoiceOperationDate']

      invoice_data = invoice['InvoiceData']

      if invoice_data.is_a?(Hash)
        puts parcel_code = invoice['InvoiceData']['ParcelCode']
        puts item_qty = invoice['InvoiceData']['ItemQty']
        puts parcel_price = invoice['InvoiceData']['ParcelPrice']
      else
        invoice_data.each do |data|
          puts parcel_code = data['ParcelCode']
          puts item_qty = data['ItemQty']
          puts parcel_price = data['ParcelPrice']
        end
      end
    end
  end
end
