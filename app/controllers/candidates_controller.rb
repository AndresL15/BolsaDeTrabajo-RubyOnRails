class CandidatesController < ApplicationController

    before_action :set_candidate, only:[:show, :update, :destroy]

    def index
        @candidates = Candidate.all
        render status: 200, json: { candidates: @candidates }
    end

    def create
        @candidate = Candidate.create(params_candidate)
        if @candidate.persisted?
            render status: 200, json: { candidate: @candidate }
        else
            render status: 404, json: { message: "No se pudo crear el candidato: #{ @candidate.errors.details }"}
        end
    end

    def show
        render status: 200, json: { candidate: @candidate }
    end

    def update
        if @candidate.update(params_candidate)
            render status: 200, json: { candidate: @candidate }
        else
            render status: 404, json: { message: "No se actualizo ese candidato: #{ @candidate.errors.details }"}
        end
    end

    def destroy
        if @candidate.destroy
            render status: 200, json: { candidate: @candidate }
        else
            render status: 404, json: { message: "No se pudo eliminar ese candidato: #{ @candidate.errors.details }"}
        end
    end

    private

        def params_candidate
            params.require(:candidate).permit(:name)
        end

        def set_candidate
            @candidate = Candidate.find_by(id: params[:id])
            if @candidate.blank?
                render status: 404, json: { message: "No se encontro ese candidato: #{params[:id] }"}
                false
            end
        end

end
