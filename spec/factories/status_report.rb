FactoryGirl.define do
  factory :status_report do
    report_date Date.today
    summary 'Sumar raport'
    association :project
    association :profile
  end
end
