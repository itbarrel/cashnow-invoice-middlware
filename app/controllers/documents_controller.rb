# frozen_string_literal: true

class DocumentsController < ApplicationController
  before_action :find_vendor
  before_action :find_document, only: %i[destroy]

  def index
    @document_groups = @vendor.document_groups

    if params[:search] && params[:search][:from_date].present?
      start_date = params[:search][:from_date]
      @document_groups = @document_groups.joins(:documents).where(
        "(documents.data->>'vendor_invoice_date')::date > ?", start_date.to_date
      ).distinct
    end
    @document_groups = @vendor.document_groups.where(id: @document_groups.ids)

    return unless params[:search] && params[:search][:to_date].present?

    end_date = params[:search][:to_date]
    @document_groups = @document_groups.joins(:documents).where(
      "(documents.data->>'vendor_invoice_date')::date < ?", end_date.to_date
    ).distinct

    @document_groups = @vendor.document_groups.where(id: @document_groups.ids)
  end

  def destroy
    @document.destroy
  end

  private

  def find_vendor
    @vendor = Vendor.find(params[:vendor_id]) if params[:vendor_id].present?
  end

  def find_document
    @document = @vendor.documents.find(params[:id])
  end
end
