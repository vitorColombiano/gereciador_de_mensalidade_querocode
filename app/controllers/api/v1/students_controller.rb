module Api
    module V1
        class StudentsController < ApplicationController
            def index
                page = params[:page].to_i > 0 ? params[:page].to_i : 1
                count = params[:count].to_i > 0 ? params[:count].to_i : 10

                students = Student.order('created_at ASC').page(page).per(count)
                formatted_student = students.map do |student|
                    {
                        id: student.id,
                        name: student.name,
                        cpf: student.cpf,
                        birthdate: student.birthdate.strftime('%d/%m/%Y'),
                        payment_method: student.payment_method
                    }
                end

                render json: { page: page, items: formatted_student }, status: :ok
            end
        end
    end
end
