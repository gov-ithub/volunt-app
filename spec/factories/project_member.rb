FactoryGirl.define do  
  factory :project_member do
    role 'Programator'
    association :project
    association :profile
  end
end
