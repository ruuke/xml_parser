class BatchesController < ApplicationController
  def new
    @batch = Batch.new
  end

  def create
    @batch = Batch.new(batch_params)
    XmlParserService.call(@batch)

    if @batch.save
      render :new, notice: "OK"
    else
      render :new
    end
  end

  private

  def batch_params
    params.require(:batch).permit(:file)
  end
end
