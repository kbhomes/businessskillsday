module Admin
  class ResultsController < AdminController

    before_filter :get_event, :get_result

    def main
      @events = Event.all
      @results = Result.all
    end

    def index
      @results = @event.results.all
    end

    def new
      @result = @event.results.build
    end

    def create
      params = result_params

      # Make sure the type parameter is valid.
      raise 'Result type is not valid' unless Result.types.include?(params[:type])
      @result = @event.results.build(params)


      if @result.save
        redirect_to admin_event_results_url(@event), notice: 'Result was successfully saved.'
      else
        render action: "new"
      end
    end

    def update
      if @result.update_attributes(result_params)
        redirect_to admin_event_results_url(@event), notice: 'Result was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @result.destroy
      redirect_to admin_event_results_url(@event), :notice => 'Successfully deleted result.'
    end

    private

      def get_event
        @event ||= Event.find(params[:event_id]) if params[:event_id]
      end

      def get_result
        @result ||= @event.results.find(params[:id]) if params[:id]
      end

      def result_params
        p = params.require(:result).permit(:score, :participant_id)
        p[:type] = @event.type == 'TeamPerformanceEvent' ? 'TeamResult' : 'StudentResult'
        p
      end
  end
end