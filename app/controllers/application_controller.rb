class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
 
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:driver, :phone, :company, :certificate, :power_id])
    end

    def after_sign_in_path_for(resource)
      @power = Power.find(current_user.power_id)
      if current_user.authority.blank? || current_user.authority == 9
        flash[:notice] = "登録まであと一歩です"
        root_path
      elsif current_user.authority == 1
        flash[:notice] = "管理画面です"
        root_path
      elsif @power.update_switch == 2
        flash[:notice] = "もうしばらくお待ちください！"
        root_path
      else
        flash[:notice] = "ログインしました。ご希望の予約登録を選択してください"
        powers_path
      end
    end


end
