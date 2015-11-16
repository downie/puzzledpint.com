class GameControl::AdminsController < GameControlController
  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
    @admin.send_invite = true
  end

  def create
    @admin = Admin.new(create_params)
    @admin.password = temp_password

    if @admin.save
      @admin.invite!
      redirect_to game_control_admins_path, notice: 'User successfully created.'
    else
      render :new
    end
  end

  def edit
    @admin = Admin.find params[:id]
  end

  def update
    @admin = Admin.find params[:id]

    if @admin.update_attributes(update_params)
      redirect_to game_control_admins_path,
                  notice: "User <strong>#{@admin.full_name}</strong> was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @admin = Admin.find params[:id]
    if @admin.destroy
      redirect_to game_control_admins_path, notice: 'User successfully deleted.'
    else
      redirect_to game_control_admins_path, alert: 'Could not delete the user.'
    end
  end

  private

  def  temp_password
    Devise.friendly_token
  end

  def create_params
    params[:admin].delete_if { |k, v| k == 'password' && v.empty? }
    params.required(:admin).permit(:full_name, :email, :send_invite)
  end

  def update_params
    params[:admin].delete_if { |k, v| k == 'password' && v.empty? }
    params.required(:admin).permit(:full_name, :email, :password)
  end
end
