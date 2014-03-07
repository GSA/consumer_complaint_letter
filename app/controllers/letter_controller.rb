class LetterController < ApplicationController
 
  def send_letter
    todays_date = params[:todays_date].blank? ? "[TODAYS DATE]" : params[:todays_date]
    company_name = params[:company_name].blank? ? "[COMPANY NAME]" : params[:company_name]
    company_street_address = params[:company_street_address].blank? ? "[COMPANY STREET ADDRESS]" : params[:company_street_address]
    company_city_state_zip = params[:company_city_state_zip].blank? ?  "[COMPANY CITY, STATE, AND ZIP CODE]" : params[:company_city_state_zip]
    transaction_date = params[:transaction_date].blank? ?  "[TRANSACTION DATE]" : params[:transaction_date]
    product_description = params[:product_description].blank? ?  "[PURCHASE INFO]" : params[:product_description]
    problem_description = params[:problem_description].blank? ?  "[COMPLAINT]" : params[:problem_description]
    resolution_text = params[:resolution_text].blank? ?  "[RESOLUTION]" : params[:resolution_text]
    records = params[:records].blank? ?  ""  : params[:records]
    resolution_date = params[:resolution_date].blank? ?  "[RESOLUTION DATE]" : params[:resolution_date]
    enclosure = params[:records].blank? ?  ""  : "Enclosure"
    
    if params[:format] == "rtf"
      letter = File.read("public/cah_template.rtf")
    else 
      letter = File.read("public/cah_template.txt")
    end
    
    letter = letter.gsub("TodaysDate", todays_date)
    letter = letter.gsub("CompanyName", company_name)
    letter = letter.gsub("CompanyStreetAddress", company_street_address)
    letter = letter.gsub("CompanyCityStateZip", company_city_state_zip)
    letter = letter.gsub("TransactionDate", transaction_date)
    letter = letter.gsub("PurchaseInfo", product_description)
    letter = letter.gsub("ComplaintText", problem_description)
    letter = letter.gsub("ResolutionText", resolution_text)
    letter = letter.gsub("RecordsText", records)
    letter = letter.gsub("ResolutionDate", resolution_date)
    letter = letter.gsub("EnclosureText", enclosure)
   
    if params[:format] == "rtf"
      file_name = "complaint_letter#{DateTime.now.to_time.to_i}.rtf"
    else
      file_name = "complaint_letter#{DateTime.now.to_time.to_i}.txt"
    end
    
    send_data letter, :type => 'text; charset=utf-8; header=present', :disposition => "attachment; filename=#{file_name}"
  end
end