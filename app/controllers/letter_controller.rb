class LetterController < ApplicationController
 
  def send_letter
    #letter = params[:letter].blank? ? "No letter text received" : params[:letter]
    highlight_prefix = "}{\\rtlch\\fcs1\\af5\\afs24 \\ltrch\\fcs0 \\f5\\fs24\\highlight7\\insrsid3615764\\charrsid8477043 "
    highlight_suffix = "}{\\rtlch\\fcs1 \\af5\\afs24 \\ltrch\\fcs0 \\f5\\fs24\\insrsid3615764 "
    todays_date = params[:todays_date].blank? ? (highlight_prefix + "[TODAYS DATE]" +  highlight_suffix).html_safe : params[:todays_date]
    company_name = params[:company_name].blank? ? (highlight_prefix + "[COMPANY NAME]" +  highlight_suffix).html_safe : params[:company_name]
    company_street_address = params[:company_street_address].blank? ? (highlight_prefix + "[COMPANY STREET ADDRESS]" +  highlight_suffix).html_safe : params[:company_street_address]
    company_city_state_zip = params[:company_city_state_zip].blank? ? (highlight_prefix + "[COMPANY CITY, STATE, AND ZIP]" +  highlight_suffix).html_safe : params[:company_city_state_zip]
    transaction_date = params[:transaction_date].blank? ? (highlight_prefix + "[TRANSACTION DATE]" +  highlight_suffix).html_safe : params[:transaction_date]
    product_description = params[:product_description].blank? ? (highlight_prefix + "[PURCHASE INFO]" +  highlight_suffix).html_safe : params[:product_description]
    problem_description = params[:problem_description].blank? ? (highlight_prefix + "[COMPLAINT]" +  highlight_suffix).html_safe : params[:problem_description]
    resolution_text = params[:resolution_text].blank? ? (highlight_prefix + "[RESOLUTION]" +  highlight_suffix).html_safe : params[:resolution_text]
    records = params[:records].blank? ? (highlight_prefix + "" +  highlight_suffix).html_safe : params[:records]
    resolution_date = params[:resolution_date].blank? ? (highlight_prefix + "[RESOLUTION DATE]" +  highlight_suffix).html_safe : params[:resolution_date]
    
    letter = File.read("public/cah_template.rtf")
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
   
    file_name = "complaint_letter#{DateTime.now.to_time.to_i}.rtf"
    send_data letter, :type => 'text; charset=utf-8; header=present', :disposition => "attachment; filename=#{file_name}"
  end
end