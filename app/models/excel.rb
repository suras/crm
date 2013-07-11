class Excel < ActiveRecord::Base
  attr_accessible :excel_sheet, :user_id
  has_attached_file :excel_sheet,
  :url  => "/jobs/excel/:basename.:extension",
                  :path => ":rails_root/public/jobs/excel/:basename.:extension" 
  validates_attachment_content_type :excel_sheet, :content_type => ["application/vnd.ms-excel",     
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"]
  


  def self.import(file, user_id)
   spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
   #Rails.logger.info "plain row: #{row}"
    row = row.to_hash
    if row['contact_number'].present?
      contact = row['contact_number'].to_s
      contact = contact.slice(0, contact.index('.'))
      row['contact_number'] = contact
    end
    row["user_id"] = user_id
    
    
     Rails.logger.warn "added row: #{row}"
     candidate = Candidate.new(row)
       candidate.save
     end
  end
  
  def self.open_spreadsheet(file)
     case File.extname(file)
     when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
     when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
     when '.xlsx' then Roo::Excelx.new(file, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
