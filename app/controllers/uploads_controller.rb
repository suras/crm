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
  
  
  #==============linked_in========
  
    def new_upload_linkedin
    @linkedin = Linkedin.new
  end
  
  def upload_linkedin
    params[:linkedin][:user_id] = current_user.id
    @linkedin = Linkedin.new(params[:linkedin])
    if @linkedin.save
      redirect_to new_upload_linkedin_path, :notice => "Upload Successfully. It will take sometime to process
      the file"
    else
      render :action => "new_upload_linkedin"
    end
    
  end
  #=====outlook===#
   def new_upload_outlook
    @outlook = Outlook.new
  end
  
  def upload_outlook
    params[:outlook][:user_id] = current_user.id
    @outlook = Outlook.new(params[:outlook])
    if @outlook.save
      redirect_to new_upload_outlook_path, :notice => "Upload Successfully. It will take sometime to process
      the file"
    else
      render :action => "new_upload_outlook"
    end
    
  end
  
  
  #===========resume===============
  
  
   def new_upload_doc
    @resume = Doc.new
  end
  
  def upload_doc
    params[:doc][:user_id] = current_user.id
    @resume = Doc.new(params[:doc])
    if @resume.save
      redirect_to new_upload_doc_path, :notice => "Upload Successfully. It will take sometime to process
      the file"
    else
      render :action => "new_upload_doc"
    end
    
  end
  
#===============resume end=================
  
  #=====class end==============
  
end
