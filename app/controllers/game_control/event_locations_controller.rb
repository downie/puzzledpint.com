class GameControl::EventLocationsController < GameControlController
  authorize_actions_for EventLocation, except: [:edit, :update]

  before_action :load_event, :add_breadcrumbs

  def new
    @location = @event.event_locations.build
    @cities = available_cities
    @states = []
  end

  def create
    @location = EventLocation.new(create_params)
    if @location.save
      redirect_to edit_game_control_event_path(@event),
                  notice: 'Location successfully created.'
    else
      @cities = available_cities
      render :new
    end
  end

  def edit
    @location = EventLocation.find params[:id]
    authorize_action_for(@location)
    generate_states
  end

  def update
    @location = EventLocation.find params[:id]
    authorize_action_for(@location)

    if @location.update_attributes(update_params)
      update_redirect
    else
      generate_states
      render :edit
    end
  end

  def destroy
    location = EventLocation.find params[:id]
    location.destroy
    redirect_to edit_game_control_event_path(@event),
                notice: 'Location successfully deleted.'
  end

  private

  def update_redirect
    if current_admin.can_update?(@event)
      redirect_to edit_game_control_event_path(@event),
                  notice: "Location was successfully updated"
    else
      redirect_to game_control_event_path(@event),
                  notice: "Location was successfully updated"
    end
  end

  def generate_states
    @states = Country.new.states(@location.addr_country).map do |s|
      OpenStruct.new(s)
    end
  end

  def available_cities
    all_cities = City.all.sort { |x, y| x.display_name <=> y.display_name }
    event_cities = @event.event_locations.map(&:city)
    all_cities - event_cities
  end

  def load_event
    @event = Event.find(params[:event_id])
  end

  def create_params
    params.require(:event_location).permit(:city_id, :event_id, :bar_name,
                                           :bar_url, :start_time, :notes,
                                           :addr_street_1, :addr_street_2, :addr_postal_code,
                                           :addr_city, :addr_state, :addr_country)
  end

  def update_params
    params.require(:event_location).permit(:bar_name, :bar_url, :start_time, :notes,
                                           :addr_street_1, :addr_street_2, :addr_postal_code,
                                           :addr_city, :addr_state, :addr_country)
  end

  def add_breadcrumbs
    add_breadcrumb "<i class='fa fa-calendar'></i> Events".html_safe, :game_control_events_path
    add_breadcrumb @event.theme, game_control_event_path(@event)
  end
end
