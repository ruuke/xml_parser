class HandleInvoicesParcelsJob < ApplicationJob
  queue_as :default

  def perform(invoice, invoice_data)
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
