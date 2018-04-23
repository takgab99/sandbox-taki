module Api
  class EducationalGoalsController < ApiController
    include NccHelper
    load_and_authorize_resource :educational_goal
    before_action :set_educational_goal, only: %i[show update]

    # GET api/{locale}/educational_goals
    def index
      @educational_goals = EducationalGoal.all
      render json: @educational_goals
    end

    # POST api/{locale}/educational_goals
    def create
      @educational_goal = EducationalGoal.new(educational_goal_params)
      @educational_goal.ncc = active_ncc

      if @educational_goal.save
        render json: @educational_goal, status: :created
      else
        render json: @educational_goal.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/{locale}/educational_goals/{id}
    def update
      if @educational_goal.update(educational_goal_params)
        render json: @educational_goal
      else
        render json: @educational_goal.errors, status: :unprocessable_entity
      end
    end

    # GET api/{locale}/educational_goals/{id}
    def show
      render json: @educational_goal
    end

    # DELETE /api/{locale}/educational_goals/{id}
    def destroy
      if @educational_goal.try(:destroy)
        head :no_content
      else
        render json: { errors: 'An error occurred during deleting message' }, status: :unprocessable_entity
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_educational_goal
      @educational_goal = EducationalGoal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def educational_goal_params
      params.require(:educational_goal).permit(:name, :description, :abbreviation)
    end
  end
end
