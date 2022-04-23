class CompaniesController < ApplicationController

    before_action :set_company, only:[:show, :update, :destroy]

    def index
        @companies = Company.all
        render status: 200, json: { companies: @companies }
    end

    def create
        @company = Company.create(params_company)
        if @company.persisted?
            render status: 200, json: { company: @company }
        else
            render status: 404, json: { message: "No se pudo crear la compania: #{ @company.errors.details }"}
        end
    end

    def show
        render status: 200, json: { company: @company }
    end

    def update
        if @company.update(params_company)
            render status: 200, json: { company: @company }
        else
            render status: 404, json: { message: "No se actualizo ese cliente: #{ @company.errors.details }"}
        end
    end

    def destroy
        if @company.destroy
            render status: 200, json: { company: @company }
        else
            render status: 404, json: { message: "No se pudo eliminar esa compania: #{ @company.errors.details }"}
        end
    end

    private

        def params_company
            params.require(:company).permit(:name)
        end

        def set_company
            @company = Company.find_by(id: params[:id])
            if @company.blank?
                render status: 404, json: { message: "No se encontro esa compania #{params[:id] }"}
                false
            end
        end

end
