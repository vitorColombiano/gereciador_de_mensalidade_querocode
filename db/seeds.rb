require 'faker'

5.times do
    Student.create(
      {name: Faker::Name.name,
      cpf: Faker::IdNumber.brazilian_citizen_number(formatted: true),
      birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
      payment_method: %w(credit_card boleto).sample}
    )
end

5.times do
    enrollment = Enrollment.create!(
      amount: Faker::Number.between(from: 100, to: 10000),
      installments: Faker::Number.between(from: 2, to: 12),
      due_day: Faker::Number.between(from: 1, to: 31),
      student_id: Student.pluck(:id).sample
    )
    enrollment.installments.times do |i|
        enrollment.bills.create!(
            amount: enrollment.amount / enrollment.installments,
            due_date: Date.today.next_month(i).change(day: enrollment.due_day),
            status: 'open'
        )
    end
end
