require "open-uri"
class UploadsController < ApplicationController
  before_filter :authenticate_user!, :except => :excel_jobs
  layout "candidate"
  
  def new_upload_excel
    @excel = Excel.new
  end
  
  def upload_excel
    params[:excel][:user_id] = current_user.id
    @excel = Excel.new(params[:excel])
    if @excel.save
      redirect_to new_upload_excel_path, :notice => "Upload Successfully. It will take sometime to process
      the file"
    else
      render :action => "new_upload_excel"
    end
    
  end
  
  def excel_jobs
    @excel = Excel.where(:status => "0").all
    @excel.each do |excel|
      
           
      #url = excel.excel_sheet.path
      #url_data = File.open(url).read()
      #Rails.logger.info "sssss test: #{url}"
      if Excel.import(excel.excel_sheet.path, excel.user_id)
        excel.status = 1
        excel.save
      end
      
    end
    
    render :nothing => true 
    
  end
  
end
