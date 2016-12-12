class RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:edit, :update]

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
    flash[:notice] = "Votre profil a bien été mis à jour !"
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :photo, :photo_cache)
  end
end
