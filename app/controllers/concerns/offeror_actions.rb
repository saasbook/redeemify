module OfferorActions
  
  def upload_page
  end

  def home
    @histories_array = Offeror.home_set(current_offeror.history)

    @hash = { "uploaded" => current_offeror.uploaded_codes,
              "used" => current_offeror.used_codes,
              "unclaimed" => current_offeror.unclaimed_codes,
              "removed" => current_offeror.removed_codes }

    gon.codes = @hash
    gon.history = current_offeror.history
  end

  def import
    if params[:file].nil?
      redirect_to "/#{params[:controller]}/upload_page", 
        :flash => { :error => "You have not selected a file to upload" }
    else
      import_status = current_offeror.import(params[:file], params[:comment])
      fail_codes = import_status[:err_codes]
      if import_status[:err_file]
        flash[:error] = import_status[:err_file]
        redirect_to "/#{params[:controller]}/upload_page" 
      elsif fail_codes > 0
        content = validation_errors_content(import_status)
        send_data(content,
          :filename => "#{fail_codes}_#{'code'.pluralize(fail_codes)}_rejected_at_submission_details.txt")
      else                                
        flash[:notice] = "#{import_status[:submitted_codes]} #{'code'.pluralize(import_status[:submitted_codes])} imported" 
        redirect_to "/#{params[:controller]}/home"
      end
    end
  end
  
  def remove_unclaimed_codes
    if offeror_codes.where(user_id: nil).count.zero?
      redirect_to "/#{params[:controller]}/home",
        :flash => { :error => "There are no unclaimed codes" }
    else
      current_offeror.remove_unclaimed_codes(offeror_codes)
      redirect_to "/#{params[:controller]}/home",
        :flash => { :notice => "Codes were removed" }
    end
  end
  
  def download_unclaimed_codes
    unclaimed_codes = current_offeror.download_unclaimed_codes(offeror_codes)
    send_data(unclaimed_codes, filename: "unclaimed_codes.txt")
  end
  
  def view_codes
    @offeror_codes = offeror_codes.all
  end

  def clear_history
    if current_offeror.history.nil?
      redirect_to "/#{params[:controller]}/home",
        :flash => { :error => "History is empty" }
    else
      current_offeror.update_attribute(:history, nil)
      redirect_to "/#{params[:controller]}/home",
        :flash => { :notice => "History was cleared" }
    end
  end
  
  private

  def require_login
    unless current_offeror
      redirect_to '/' and return
    end
  end
end