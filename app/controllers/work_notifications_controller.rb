class WorkNotificationsController < ApplicationController
    
    before_action :set_company
    before_action :set_work_notification, only:[:show, :update, :destroy]

    def index
        @work_notifications = @company.work_notifications
        render status: 200, json: { work_notifications: @work_notifications }
    end

    def create
        @work_notification = @company.work_notifications.build(params_work_notification)
        if @work_notification.save
            render status: 200, json: { work_notification: @work_notification }
        else
            render status: 404, json: { message: "No se pudo crear el aviso de trabajo: #{ @work_notification.errors.details }" }
        end
    end

    def show
        render status: 200, json: { work_notification: @work_notification }
    end

    def update
        if @workNotification.update(params_work_notification)
            render status: 200, json: { workNotification: @workNotification }
        else
            render status: 404, json: { message: "No se actualizo ese cliente: #{ @workNotification.errors.details }"}
        end
    end

    def destroy
        if @client.destroy
            render status: 200, json: { client: @client }
        else
            render status: 404, json: { message: "No se pudo eliminar ese cliente: #{ @client.errors.details }"}
        end
    end

    private

        def params_work_notification
            params.require(:work_notification).permit(:name)
        end

        def set_company
            @company = Company.find_by(id: params[:company_id])
            if @company.blank?
                render status: 404, json: { message: "No se encontro ese cliente #{params[:company_id] }"}
                false
            end
        end

        def set_work_notification
            @work_notification = WorkNotification.find_by(id: params[:id])
            if @work_notification.blank?
                render status: 404, json: { message: "No se encontro ese aviso de trabajo #{params[:id] }"}
                false
            end
        end

end
