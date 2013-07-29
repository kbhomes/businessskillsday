module Admin
  class EventsController < AdminController

    before_filter :get_event

    def index
      @admin_events = Event.all.page(params[:page])
    end

    def show
    end

    def new
      @admin_event = Event.new
    end

    def edit
    end

    def create
      event_params = admin_event_params

      # Make sure the type parameter is valid.
      raise 'Event type is not valid' unless Event.types.include?(event_params[:type])
      @admin_event = (event_params[:type].constantize).new(event_params)

      if @admin_event.save
        redirect_to admin_event_path(@admin_event), notice: 'Event was successfully created.'
      else
        render action: "new"
      end
    end

    def update
      if @admin_event.update_attributes(admin_event_params)
        redirect_to admin_event_path(@admin_event), notice: 'Event was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @admin_event.destroy
      redirect_to admin_events_url, notice: "Successfully deleted #{@admin_event.type.underscore.humanize.downcase} #{@admin_event.name}"
    end

    private

      def get_event
        @admin_event = Event.find(params[:id]) if params[:id]
      end

      def admin_event_params
        params.require(:admin_event).permit(:number, :name, :nine_ten, :type)
      end
  end
end