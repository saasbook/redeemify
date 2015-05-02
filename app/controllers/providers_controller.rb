class ProvidersController < ApplicationController

  def index
  end
# --------------------------
  def import2
    if params[:file].nil?
      redirect_to '/providers/upload_page', :flash => { :error => "You have not upload a file" }
    else
      current_provider=Provider.find(session[:provider_id])
      
      Vendor.import(params[:file], current_provider,params[:comment], "provider")
      redirect_to '/providers/home', notice: "Codes imported"
    end
  end


# ---------------
  def home
    @provider = Provider.find(session[:provider_id])
    @providerCodes= @provider.providerCodes

    @histories_array=[]

    if  @provider.history != nil
      @histories_array = Vendor.homeSet(@provider.history)
    end

    @hash = {"uploaded" => @provider.uploadedCodes,  "used" => @provider.usedCodes, "unclaim" => @provider.unclaimCodes, "removed" => @provider.removedCodes }
    gon.codes = @hash
    gon.history = @provider.history

  end


  def upload_page
    @provider = Provider.find(session[:provider_id])
    @providerCodes= @provider.providerCodes.all
  end


  def remove_codes
    current_provider=Provider.find(session[:provider_id])
    flag = current_provider.providerCodes.where(:user_id => nil)
    if flag.count == 0
      redirect_to '/providers/home ', :flash => { :error => "There's No Unclaimed Codes" }
    else
      contents = Vendor.remove_unclaimed_codes(current_provider, "provider")
      send_data contents,  :filename => "Unclaimed_Codes.txt"
    end
  end

  def clear_history
    current_provider=Provider.find(session[:provider_id])
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
