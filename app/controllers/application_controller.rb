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

  def permitted_except_viewer(object)
    object.all_permitted_members.gsub(current_person.first_name, "You")
  end
  helper_method :permitted_except_viewer

  def destroy_response(object)
    respond_to do |f|
      if current_person == object.owner
        object.destroy
        f.html { redirect_to "/families/#{params[:id]}/#{object.class.to_s.downcase.pluralize}" }
        f.js {render 'destroy'}
      else
        @msg = "Sorry, something went wrong."
        f.js {render 'layouts/destroy_failure', locals: {msge: @msg}}
        f.html {render 'show'}
        # flash[:alert] = "Sorry, something went wrong."
      end
    end
  end

  private

  def print_errors_for(resource)
    messages = resource.errors.full_messages
    error_string = "This #{resource.class.to_s.downcase} could not be created: "
    messages.each do |message|
      error_string << "#{message}. "
    end
    error_string
  end
  
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
