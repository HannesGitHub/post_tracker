class Users::TrackingsController < Users::BaseUsersController
  def index
    @trackings = Tracking.active_and_ongoing
  end

  def completed_trackings
    @trackings = Tracking.completed
    render 'index'
  end

  def failed_trackings
    @trackings = Tracking.failed
    render 'index'
  end

  def create
    @tracking = Tracking.new(tracking_params)
    if @tracking.save
      # Register tracking on trackmore website and handle response that is received from trackmore website.
      TrackMoreWorker.perform_async(track_more_api.register_tracking(tracking_params[:tracking_number], @tracking))
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

  def retry_tracking
    tracking = Tracking.find(params[:id])
    TrackMoreWorker.perform_async(track_more_api.register_tracking(tracking.tracking_number, tracking))
    redirect_to action: :index
  end

  def mark_completed
    tracking = Tracking.find(params[:id])
    tracking.is_completed = true
    tracking.save
    redirect_to action: :index
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

  def statuses
    @tracking = Tracking.find(params[:id])
    render partial: 'tracking_statuses'
  end

  private
  def tracking_params
    params.require(:tracking).permit(:id, :tracking_number, :user_id, :is_active, :description)
  end
end