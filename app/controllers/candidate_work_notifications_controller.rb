class CandidateWorkNotificationsController < ApplicationController

    before_action :set_candidate, only:[:index, :create]
    before_action :set_work_notification, only:[:create, :show, :update, :destroy]
    before_action :set_candidate_work, only:[:show, :update, :destroy]

    def index
        @candidate_works = @candidate.candidate_work_notifications
        render status: 200, json: { candidate_works: @candidate_works }
    end

    def create
        @candidate_work = @candidate.candidate_work_notifications.build(params_ca_wo_no)
        @notification_work = @work_notification.candidate_work_notifications.build(params_ca_wo_no)
        if @candidate_work.save && @notification_work
            render status: 200, json: { candidate_work: @candidate_work }
        else
            render status: 404, json: { message: "No se pudo crear el aviso de trabajo: #{ @candidate_work.errors.details }" }
        end
    end

    def show
        render status: 200, json: { work_notification: @work_notification }
    end

    def update
        if @candidate_work.update(params_update)
            render status: 200, json: { candidate_work: @candidate_work }
        else
            render status: 404, json: { message: "No se actualizo ese cliente: #{ @candidate_work.errors.details }"}
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

        def params_ca_wo_no
            params.require(:candidate_work_notification).permit(:status, :work_notification_id)
        end

        def params_update
            params.require(:candidate_work_notification).permit(:status)
        end

        def set_candidate
            @candidate = Candidate.find_by(id: params[:candidate_id])
            if @candidate.blank?
                render status: 404, json: { message: "No se encontro ese cliente #{params[:candidate_id] }"}
                false
            end
        end

        def set_candidate_work
            @candidate_work = CandidateWorkNotification.find_by(id: params[:id])
            if @candidate_work.blank?
                render status: 404, json: { message: "No se encontro ese cliente #{params[:id] }"}
                false
            end
        end

        def set_work_notification
            @work_notification = WorkNotification.find_by(id: params[:work_notification_id])
            if @work_notification.blank?
                render status: 404, json: { message: "No se encontro ese aviso de trabajo #{params[:work_notification_id] }"}
                false
            end
        end

end
