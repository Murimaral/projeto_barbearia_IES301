class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @replied_rescue_requests = replied_requests
    @awaiting_rescue_requests = awaiting_rescue_requests
    @my_rescue_requests = my_rescue_requests
    @accepted_rescue_requests = accepted_rescue_requests
  end

  def ban
    @user = User.find(params[:user_id])
  end

  def destroy_user
    @user = User.find(params[:user_id])
    Pet.where(user: @user).each { |pet| pet.update(active: false) }
    RescueRequest.where(owner_id: @user.id).each { |request| request.update(status: :cancelled) }
    RescueRequest.where(rescuer_id: @user.id).each { |request| request.update(status: :cancelled) }
    @user.update(name: 'Usuário não encontrado')
    @user.destroy

    redirect_to root_path
  end

  private

  def awaiting_rescue_requests
    where_rescuer = RescueRequest.where(owner_id: current_user.id)
                                 .where(created_by_owner: false)
                                 .where(status: :open)
                                 .order('updated_at DESC')
    where_owner = RescueRequest.where(rescuer_id: current_user.id)
                               .where(created_by_owner: true)
                               .where(status: :open)
                               .order('updated_at DESC')
    [].push(*where_owner, *where_rescuer)
  end

  def my_rescue_requests
    where_rescuer = RescueRequest.where(owner_id: current_user.id)
                                 .where(created_by_owner: true)
                                 .where(status: :open)
                                 .order('updated_at DESC')
    where_owner = RescueRequest.where(rescuer_id: current_user.id)
                               .where(created_by_owner: false)
                               .where(status: :open)
                               .order('updated_at DESC')
    [].push(*where_owner, *where_rescuer)
  end

  def replied_requests
    where_rescuer = RescueRequest.where(owner_id: current_user.id)
                                 .where(created_by_owner: true)
                                 .order('updated_at DESC')
    where_owner = RescueRequest.where(rescuer_id: current_user.id)
                               .where(created_by_owner: false)
                               .order('updated_at DESC')
    results = [].push(*where_owner, *where_rescuer)
    results.reject { |request| request[:status] == 'open' }
  end

  def accepted_rescue_requests
    where_rescuer = RescueRequest.where(owner_id: current_user.id)
                                 .where(created_by_owner: false)
                                 .order('updated_at DESC')
    where_owner = RescueRequest.where(rescuer_id: current_user.id)
                               .where(created_by_owner: true)
                               .order('updated_at DESC')
    results = [].push(*where_owner, *where_rescuer)
    results.select { |request| request[:status] == 'accepted' }
  end
end
