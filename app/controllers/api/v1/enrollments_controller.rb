module Api
    module V1
        class EnrollmentsController < ApplicationController
            def index
                page = params[:page].to_i > 0 ? params[:page].to_i : 1
                count = params[:count].to_i > 0 ? params[:count].to_i : 10

                enrollments = Enrollment.includes(:bills).page(page).per(count)
                formatted_enrollment = enrollments.map { |enrollment| enrollment_json(enrollment) }
                end
                render json: { page: page, item: formatted_enrollment }, status: :ok
            end

            def create
                enrollment = Enrollment.new(enrollment_params)

                if enrollment.save
                    crete_bills(enrolment)
                    render json: enrollment_json(enrollment), status: :created
                else
                    render json: { errors: enrollment.errors.full_messages }, status: :unprocessable_entity
                end
            end

            private

            def enrollment_params
                params.require(:enrollment).permit(:amout, :installments, :due_day, :student_id)
            end

            def crete_bills(enrollment)
                amount_per_bill = enrollment.amout / enrollment.installments
                due_day = enrollment.due_day
                current_day = Date.today

                enrollment.installments.times do |i|
                    due_date = if due_date < current_day.day
                        (current_date + (i+1).months).change(day: due_day)
                    else
                        (current_date + i.months).change(day: due_day)
                    end
                    
                    enrollment.bills.create(
                        amount: amount_per_bill,
                        due_date: due_date,
                        status: 'open'
                    )
                end
            end


            def enrollment_json(enrollment)
                {
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
                }
            end
        end
    end
end