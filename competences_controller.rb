module Api
  class CompetencesController < ApiController
    include NccHelper
    load_and_authorize_resource :competence
    before_action :set_competence, only: %i[show update]

    # GET api/{locale}/competences
    def index
      @competences = Competence.all
      render json: @competences
    end

    # POST api/{locale}/competences
    def create
      @competence = Competence.new(competence_params)
      @competence.ncc = active_ncc

      if @competence.save
        render json: @competence, status: :created
      else
        render json: @competence.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/{locale}/competences/{id}
    def update
      if @competence.update(competence_params)
        render json: @competence
      else
        render json: @competence.errors, status: :unprocessable_entity
      end
    end

    # GET api/{locale}/competences/{id}
    def show
      render json: @competence
    end

    # DELETE /api/{locale}/competences/{id}
    def destroy
      if @competence.try(:destroy)
        head :no_content
      else
        render json: { errors: 'An error occurred during deleting message' }, status: :unprocessable_entity
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_competence
      @competence = Competence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competence_params
      params.require(:competence).permit(:name, :description, :abbreviation)
    end
  end
end
