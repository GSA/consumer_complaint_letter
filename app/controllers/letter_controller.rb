class LetterController < ApplicationController
 
  def send_letter
    letter = params[:letter].blank? ? "No letter text received" : params[:letter]
    file_name = "complaint_letter#{DateTime.now.to_time.to_i}.rtf"
    send_data letter, :type => 'text; charset=utf-8; header=present', :disposition => "attachment; filename=#{file_name}"
  end
end