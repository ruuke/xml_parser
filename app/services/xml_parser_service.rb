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

    HandleInvoicesParcelsJob.perform_now(new_invoice, invoice['InvoiceData'])
  end
end
