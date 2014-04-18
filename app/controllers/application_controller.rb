class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  def provide_relationships(family)
    @other_members = current_person.my_family_members
    @relationships = Person::GROUP_RELATIONSHIPS
  end
  
  def set_family
    @family = find_family(params[:id])
  end

  def capitalize_string(arg)
    arg.gsub('_', ' ').split(' ').collect(&:capitalize).join(' ')
  end
  helper_method :capitalize_string

  def permitted_except_viewer(object)
    object.all_permitted_members.gsub(current_person.first_name, "You")
  end
  helper_method :permitted_except_viewer

  private
  
  def configure_permitted_parameters
    #this is a total security risk. need to revisit.
      [:first_name, :age, :birthday, :data, :admin, :gender, :profile_photo].each do |param|
      devise_parameter_sanitizer.for(:sign_up) << param
      devise_parameter_sanitizer.for(:account_update) << param
    end
  end

  def find_family(slug)
    Family.find_by(name_slug: slug)
  end
end
