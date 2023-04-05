class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :composition])
  end

  def after_sign_in_path_for(resource)
    if current_member
      flash[:notice] = "ログインしました"
      posts_path
    else
      flash[:notice] = "新規登録しました。"
      posts_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :public
       root_path
    elsif resource_or_scope == :admin
       new_admin_session_path
    else
       root_path
    end
  end

end
