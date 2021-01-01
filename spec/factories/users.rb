FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 6, mix_case: true)}
    password_confirmation {password}
    first_name {"技術"}
    last_name {"太郎"}
    first_reading_name {"ギジュツ"}
    last_reading_name {"タロウ"}
    birth_date {Faker::Date.between(from: '2020-09-23', to: '2021-09-25')}                                  
  end
end
