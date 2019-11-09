class XmlParserService
  def self.call(batch)
    new(batch).call
  end

  def initialize(batch)
    @batch = batch
    @batch_guid = nil
    @batch_data = nil
    @invoices = nil
  end

  def call
    parse_data
    batch_update
  end

  def parse_data
    # binding.pry
    xml = File.open("#{@batch.file_path}")
    doc = Hash.from_xml(xml)

    @batch_guid = doc['Root']['FileAttribute']['GUID']
    @batch_data = doc['Root']['FileData']['Batch']
    @invoices = doc['Root']['FileData']['Invoice']
  end

  def batch_update
    @batch.guid = @batch_guid
    @batch.batch_id = @batch_data['BatchID']
    @batch.creation_date = @batch_data['CreationDate']
  end
end


    # batch_id = batch_data['BatchID']
    # batch_creation_date = batch_data['CreationDate']


    # invoices.each do |invoice|
    #   invoice_operation = invoice['InvoiceOperation']
    #   puts company_code = invoice_operation['CompanyCode']
    #   puts invoice_operation_number = invoice_operation['InvoiceOperationNumber']
    #   puts invoice_operation_date = invoice_operation['InvoiceOperationDate']

    #   invoice_data = invoice['InvoiceData']

    #   if invoice_data.is_a?(Hash)
    #     puts parcel_code = invoice['InvoiceData']['ParcelCode']
    #     puts item_qty = invoice['InvoiceData']['ItemQty']
    #     puts parcel_price = invoice['InvoiceData']['ParcelPrice']
    #   else
    #     invoice_data.each do |data|
    #       puts parcel_code = data['ParcelCode']
    #       puts item_qty = data['ItemQty']
    #       puts parcel_price = data['ParcelPrice']
    #     end
    #   end
    # end
