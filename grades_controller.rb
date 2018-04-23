module Api
  class GradesController < ApiController
    include NccHelper
    load_and_authorize_resource :grade
    before_action :set_grade, only: %i[show update]

    # GET api/{locale}/grades
    def index
      @grades = Grade.all
      render json: @grades
    end

    # POST api/{locale}/grades
    def create
      @grade = Grade.new(grade_params)
      @grade.ncc = active_ncc

      if @grade.save
        render json: @grade, status: :created
      else
        render json: @grade.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/{locale}/grades/{id}
    def update
      if @grade.update(grade_params)
        render json: @grade
      else
        render json: @grade.errors, status: :unprocessable_entity
      end
    end

    # GET api/{locale}/grades/{id}
    def show
      render json: @grade
    end

    # DELETE /api/{locale}/grades/{id}
    def destroy
      if @grade.try(:destroy)
        head :no_content
      else
        render json: { errors: 'An error occurred during deleting message' }, status: :unprocessable_entity
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_params
      params.require(:grade).permit(:name, :abbreviation)
    end
  end
end
