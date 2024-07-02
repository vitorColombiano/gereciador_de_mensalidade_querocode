module Api
    module V1
        class EnrollmentsController < ApplicationController
            def index
                page = params[:page].to_i > 0 ? params[:page].to_i : 1
                count = params[:count].to_i > 0 ? params[:count].to_i : 10

                enrollments = Enrollment.includes(:bills).page(page).per(count)
                formatted_enrollment = enrollments.map do |enrollment|
                    {
                        id: enrollment.id,
                        student_id: enrollment.student_id,
                        amount: enrollment.amount,
                        installments: enrollment.installments,
                        due_day: enrollment.due_day,
                        bills: enrollment.bills.map do |bill|
                            {
                                id: bill.id,
                                enrollment_id: bill.enrollment_id,
                                amount: bill.amount,
                                due_date: bill.due_date.strftime("%Y-%m-%d"),
                                status: bill.status
                            }
                        end
                    }
                end
                render json: { page: page, item: formatted_enrollment }, status: :ok
            end
        end
    end
end