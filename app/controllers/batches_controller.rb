require 'rexml/document'

class BatchesController < ApplicationController
  before_action :set_batch, only: %i[show]

  rescue_from ActionController::ParameterMissing, with: :rescue_unattached_file
  # обрабатываем все что не соответсвует валидному файлу
  rescue_from REXML::ParseException, with: :rescue_parse_exception
  # все уникальные ключи будут давать ошибку при повторной загрузке
  rescue_from PG::UniqueViolation, with: :rescue_duplicate
  # плохо, но куда деваться, обрабатываем nil'ы и отсутстие данных файле
  rescue_from NoMethodError, with: :rescue_no_method_error

  def new
    @batch = Batch.new
  end

  def create
    @batch = Batch.new(batch_params)
    XmlParserService.call(@batch)

    if @batch.save
      redirect_to @batch, notice: "OK"
    else
      render :new
    end
  end

  def show; end

  private

  def set_batch
    @batch = Batch.find(params[:id])
  end

  def batch_params
    params.require(:batch).permit(:file)
  end

  def rescue_unattached_file
    redirect_to new_batch_url, notice: 'Прикрепите файл.'
  end

  def rescue_parse_exception
    redirect_to new_batch_url, notice: 'Невалидное содержимое файла.'
  end

  def rescue_duplicate
    redirect_to new_batch_url, notice: 'Попытка повторной загрузки списка.'
  end

  def rescue_no_method_error
    redirect_to new_batch_url, notice: 'Невалидное содержимое файла.'
  end
end
