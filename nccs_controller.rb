module Api
  class NccsController < ApiController
    load_and_authorize_resource :ncc
    before_action :set_ncc, only: %i[show update]

    # GET api/nccs
    def index
      @nccs = Ncc.all
      render json: @nccs
    end

    # POST api/nccs
    def create
      @ncc = Ncc.new(ncc_params)

      if @ncc.save
        render json: @ncc, status: :created
      else
        render json: @ncc.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/nccs/1
    def update
      if @ncc.update(ncc_params)
        render json: @ncc
      else
        render json: @ncc.errors, status: :unprocessable_entity
      end
    end

    def show
      render json: @ncc
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_ncc
      @ncc = Ncc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ncc_params
      params.require(:ncc).permit(:version, :description, :status)
    end
  end
end
