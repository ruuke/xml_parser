# Сервис парсинга и создания объектов в БД из прикрепленного файла
class XmlParserService
  def self.call(batch)
    new(batch).call
  end

  def call
    parse_xml_data
    batch_update
    handle_invoices
  end

  private

  def initialize(batch)
    @batch = batch
    @batch_guid = nil
    @batch_data = nil
    @invoice = nil
  end

  # получаем данные из xml файла
  def parse_xml_data
    xml = File.open("#{@batch.file_path}")
    doc = Hash.from_xml(xml)

    @batch_guid = doc['Root']['FileAttribute']['GUID']
    @batch_data = doc['Root']['FileData']['Batch']
    @invoice = doc['Root']['FileData']['Invoice']
  end

  # обновляем атрибуты переданносго в сервис объекта и проверяем уникальность GUID
  def batch_update
    @batch.guid = @batch_guid
    @batch.id = @batch_data['BatchID']
    @batch.creation_date = @batch_data['CreationDate']
  end

  # создаем объекты накладных
  def handle_invoices
    if @invoice.is_a?(Hash)
      create_invoice(@invoice)
    else
      @invoice.each { |invoice| create_invoice(invoice) }
    end
  end

  def create_invoice(invoice)
    new_invoice = @batch.invoices.build

    new_invoice.company_code = invoice['InvoiceOperation']['CompanyCode']
    new_invoice.invoice_operation_number = invoice['InvoiceOperation']['InvoiceOperationNumber']
    new_invoice.invoice_operation_date = invoice['InvoiceOperation']['InvoiceOperationDate']

    handle_invoices_parcels(new_invoice, invoice['InvoiceData'])
  end

  # создаем посылки
  def handle_invoices_parcels(invoice, invoice_data)
    if invoice_data.is_a?(Hash)
      create_invoices_parcel(invoice, invoice_data)
    else
      invoice_data.each { |data| create_invoices_parcel(invoice, data) }
    end
  end

  def create_invoices_parcel(invoice, invoice_data)
    create_parcel(invoice_data['ParcelCode'], invoice_data['ParcelPrice'])

    invoice.invoices_parcels.build(
      parcel_id: invoice_data['ParcelCode'],
      item_qty: invoice_data['ItemQty']
    )
  end

  # создаем товары
  def create_parcel(code, price)
    Parcel.create(code: code, price: price)
  end
end
