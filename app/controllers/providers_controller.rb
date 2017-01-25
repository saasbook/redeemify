class ProvidersController < ApplicationController

  def index
  end

  def import2
    if params[:file].nil?
      redirect_to '/providers/upload_page',
      :flash => { :error => "You have not selected a file to upload" }
    else
      importStatus = Vendor.import(params[:file], current_provider,
                    params[:comment], "provider")
      failedCodes = importStatus[:errCodes]
      if failedCodes != 0
        importedCodes = importStatus[:submittedCodes] - importStatus[:errCodes]
        content = validation_errors_content(importStatus)
        send_data(content, :filename => "#{failedCodes}_#{'code'.pluralize(failedCodes)}_rejected_at_submission_details.txt")
      else
        redirect_to '/providers/home', 
        :flash => {notice: "#{importStatus[:submittedCodes]} #{'code'.pluralize(importStatus[:submittedCodes])} imported"}
      end
    end
  end

  def home
    @redeemifyCodes = current_provider.redeemifyCodes
    @histories_array = []

    if current_provider.history != nil
      @histories_array = Vendor.homeSet(current_provider.history)
    end

    @hash = { "uploaded" => current_provider.uploadedCodes,
              "used" => current_provider.usedCodes,
              "unclaim" => current_provider.unclaimCodes,
              "removed" => current_provider.removedCodes }

    gon.codes = @hash
    gon.history = current_provider.history
  end

  def upload_page
    @redeemifyCodes = current_provider.redeemifyCodes.all
  end

  def remove_codes
    flag = current_provider.redeemifyCodes.where(:user_id => nil)
    if flag.count == 0
      redirect_to '/providers/home ',
      :flash => { :error => "There's No Unclaimed Codes" }
    else
      contents = Vendor.remove_unclaimed_codes(current_provider, "provider")
      send_data contents, :filename => "Unclaimed_Codes.txt"
    end
  end

  def clear_history
    if current_provider.history.nil?
      redirect_to '/providers/home', :flash => { :error => "History is empty" }
    else
      current_provider.update_attribute(:history, nil)
      redirect_to '/providers/home', notice: "Cleared History"
    end
  end

  def show
  end

  def edit
  end

  def hello
  end

  def welcome
  end

  def enter
  end

  def exit
  end

  def login
  end

  def logout
  end

end
