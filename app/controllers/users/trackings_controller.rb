class Users::TrackingsController < Users::BaseUsersController
  def index
    @trackings = Tracking.active_scope
  end

  def create
    @tracking = Tracking.new(tracking_params)
    if @tracking.save
      # Saves successfully
      redirect_to action: :index
    else
      # Error saving tracking
      render 'new'
    end
  end

  def update
    @tracking = Tracking.find(tracking_params[:id])
    if @tracking.update_attributes(tracking_params)
      redirect_to users_trackings_url
    else
      @description = 'Edit tracking'
      render 'edit'
    end
  end

  def new
    @description = 'Add tracking'
    @tracking = Tracking.new
  end

  def edit
    @description = 'Edit tracking'
    @tracking = Tracking.find(params[:id])
  end

  def show
    @tracking = Tracking.find(params[:id])
  end

  def delete
    @tracking = Tracking.find(params[:id])
    @tracking.is_active = false
    @tracking.save
    redirect_to users_trackings_url
  end


  private
  def tracking_params
    params.require(:tracking).permit(:id, :tracking_number, :user_id, :is_active)
  end
end