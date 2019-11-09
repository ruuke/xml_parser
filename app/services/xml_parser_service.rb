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
    create_invoices
  end

  private

  def parse_data
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

  def create_invoices
    if @invoices.is_a?(Hash)
      @new_invoice = @batch.invoices.build

      @new_invoice.company_code = @invoices['InvoiceOperation']['CompanyCode']
      @new_invoice.invoice_operation_number = @invoices['InvoiceOperation']['InvoiceOperationNumber']
      @new_invoice.invoice_operation_date = @invoices['InvoiceOperation']['InvoiceOperationDate']

      create_invoices_parcels(@new_invoice, @invoices['InvoiceData'])
    else
      @invoices.each do |invoice|
        @new_invoice = @batch.invoices.build

        @new_invoice.company_code = invoice['InvoiceOperation']['CompanyCode']
        @new_invoice.invoice_operation_number = invoice['InvoiceOperation']['InvoiceOperationNumber']
        @new_invoice.invoice_operation_date = invoice['InvoiceOperation']['InvoiceOperationDate']

        create_invoices_parcels(@new_invoice, invoice['InvoiceData'])
      end
    end
  end

  def create_invoices_parcels(invoice, data)
    invoice_data = data
    new_invoice = invoice

    if invoice_data.is_a?(Hash)
      create_parcel(invoice_data['ParcelCode'], data['ParcelPrice'])

      new_invoice.invoices_parcels.build(
        parcel_id: invoice_data['ParcelCode'],
        item_qty: invoice_data['ItemQty'],
        parcel_price: invoice_data['ParcelPrice']
      )
    else
      invoice_data.each do |data|
        create_parcel(data['ParcelCode'], data['ParcelPrice'])

        new_invoice.invoices_parcels.build(
          parcel_id: data['ParcelCode'],
          item_qty: data['ItemQty'],
          parcel_price: data['ParcelPrice']
        )
      end
    end
  end

  def create_parcel(parcel_code, parcel_price)
    Parcel.create(parcel_code: parcel_code, parcel_price: parcel_price) unless Parcel.exists?(parcel_code: parcel_code)
  end
end
