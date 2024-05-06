FactoryBot.define do
  factory :user do
    # nickname              {'test'}
    # email                 {'test@example'}
    # password              {'000000'}
    # password_confirmation {password}
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    family_name {"橋本"}
    first_name {"環奈"}
    family_name_kana {"ハシモト"}
    first_name_kana {"カンナ"}
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 200) }
  end
end
# Fakerは日本語に対応していない