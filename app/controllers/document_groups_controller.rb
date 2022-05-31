# frozen_string_literal: true

class DocumentGroupsController < ApplicationController
  before_action :find_document_group, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token, only: [:update]

  def show
    @documents = @ig.filtered_documents(
      begin
        params[:search][:from_date]
      rescue StandardError
        nil
      end,
      begin
        params[:search][:to_date]
      rescue StandardError
        nil
      end
    )
    respond_to do |format|
      format.csv { send_data @documents.to_csv, filename: "#{@ig.title}.csv" }
      format.xls { headers['Content-Disposition'] = "attachment; filename=\"#{@ig.title}.xls\"" }
      @ig.update(downloaded: true)
    end
  end

  def update
    @ig.update(ig_params)
  end

  def destroy
    @ig.destroy
  end

  private

  def find_document_group
    @ig = DocumentGroup.find(params[:id]) if params[:id].present?
  end

  def ig_params
    params.require(:document_group).permit(:downloaded)
  end
end
