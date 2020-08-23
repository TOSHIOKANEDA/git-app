# class ManualsController < ApplicationController

#   # include CommonActions
#   # before_action :authenticate_user!, except: [:index]

#   def new
#     @manual = Manual.new
#   end

#   def index
#       @manuals = Manual.all
#   end

#   def create
#       @manual = Manual.new(manual_params)
#       if @manual.save
#         redirect_back(fallback_location: root_path)
#       else
#         render :new
#       end
#   end

#   private

#   def manual_params
    
#       params.require(:manual).permit(:image).merge(user_id: current_user.id)
#   end

# end
