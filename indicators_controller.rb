module Api
  class IndicatorsController < ApiController
    load_and_authorize_resource :indicator
    before_action :set_indicator, only: %i[show update]

    # GET api/{locale}/indicators
    def index
      @indicators = Indicator.all
      render json: @indicators
    end

    # GET api/{locale}/indicators/new
    def new
      render json: {
        meta: {
          standards: ::ActiveModel::Serializer::CollectionSerializer.new(Standard.all, serializer: StandardSerializer,
                                                                                      for_select: true)
        }
      }
    end

    # POST api/{locale}/indicators
    def create
      @indicator = Indicator.new(indicator_params)

      if @indicator.save
        render json: @indicator, status: :created
      else
        render json: @indicator.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/{locale}/indicators/{id}
    def update
      if @indicator.update(indicator_params)
        render json: @indicator
      else
        render json: @indicator.errors, status: :unprocessable_entity
      end
    end

    # GET api/{locale}/indicators/{id}
    def show
      render json: @indicator, meta: {
        standards: ::ActiveModel::Serializer::CollectionSerializer.new(Standard.all, serializer: StandardSerializer,
                                                                      for_select: true)
      }
    end

    # DELETE /api/{locale}/indicators/{id}
    def destroy
      if @indicator.try(:destroy)
        head :no_content
      else
        render json: { errors: 'An error occurred during deleting message' }, status: :unprocessable_entity
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_indicator
      @indicator = Indicator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def indicator_params
      params.require(:indicator).permit(:name, :standard_id)
    end
  end
end
