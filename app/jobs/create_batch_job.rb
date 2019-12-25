class CreateBatchJob < ApplicationJob
  queue_as :default

  def perform(batch)
    XmlParserService.call(batch)
  end
end
