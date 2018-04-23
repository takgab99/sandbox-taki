module Api
  class SchoolTypesController < ApiController
    include NccHelper
    load_and_authorize_resource :school_type
    before_action :set_school_type, only: %i[show update]

    # GET api/{locale}/school_types
    def index
      @school_types = SchoolType.all
      render json: @school_types
    end

    # POST api/{locale}/school_types
    def create
      @school_type = SchoolType.new(school_type_params)
      @school_type.ncc = active_ncc

      @school_type.ncc = Ncc.first # fixme

      if @school_type.save
        render json: @school_type, status: :created
      else
        render json: @school_type.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/{locale}/school_types/{id}
    def update
      if @school_type.update(school_type_params)
        render json: @school_type
      else
        render json: @school_type.errors, status: :unprocessable_entity
      end
    end

    # GET api/{locale}/school_types/{id}
    def show
      render json: @school_type
    end

    # DELETE /api/{locale}/school_types/{id}
    def destroy
      if @school_type.try(:destroy)
        head :no_content
      else
        render json: { errors: 'An error occurred during deleting message' }, status: :unprocessable_entity
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_school_type
      @school_type = SchoolType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_type_params
      params.require(:school_type).permit(:name, :description, :abbreviation, :ncc_id)
    end
  end
end
