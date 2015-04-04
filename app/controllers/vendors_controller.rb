class VendorsController < ApplicationController

  def index
    # @vendor = Vendor.find(session[:vendor_id])
  end
# --------------------------
  def import
    current_vendor=Vendor.find(session[:vendor_id])
    @info = {}
    @info["description"] = params[:description] 
    @info["instruction"] = params[:instruction]
    @info["help"] = params[:helpLink]
    @info["expiration"] = params[:expiration]

    # current_vendor.update_attribute(:history ="")
    # history = current_vendor.history
    # temp = 
    # history.push(",,,")
    # debugger
    Vendor.import(params[:file], current_vendor,@info)
    
    # history = current_vendor.history
    # temp = 
    # history.push(",,,")

    redirect_to '/vendors/home', notice: "Codes imported"
  end


# ---------------
  def home
    @vendor = Vendor.find(session[:vendor_id])
    @vendorcodes= @vendor.vendorCodes

    @codesRemain = @vendorcodes.where(:user_id => nil).count
    @codesUsed = @vendorcodes.count - @codesRemain


    @histories = @vendor.history
    if @histories != nil
      @histories = @histories.split("|||||")


      # @history1 = histories[0].split("+++++")

      @histories_array=[]
      @histories.each do |history|
        temp = history.split("+++++")
        @histories_array.push(temp)
      end
    else
      @histories_array=[]
    end
  end


  def upload_page
    @vendor = Vendor.find(session[:vendor_id])
    @vendorcodes= @vendor.vendorCodes.all
  end

  def viewCodes
    @vendor = Vendor.find(session[:vendor_id])
    @vendorcodes = @vendor.vendorCodes

  end


  def show
  end

  def edit
  end

  # def destroy
  #   session[:vendor_id] = nil
  #   redirect_to root_url, notice: "Signed out!"
  # end

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
