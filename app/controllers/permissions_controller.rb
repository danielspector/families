class PermissionsController < ApplicationController
  include Permissable
  before_action :set_resource

  def group
    @slugs = get_people(params[:permissions])
    render 'group.js'
  end

  def individual
    @id = get_relation(params[:permissions])
    render 'individual.js'
  end

  def make_hash
    current_person.checkbox_hash
    render nothing: true
  end

  private

  def set_resource
    @resources = ["albums", "conversations", "events"]
    @split_url = request.referrer.split("/")
    @resource = (@split_url & @resources).first.chop
  end
end