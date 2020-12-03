FactoryBot.define do
  factory :user do
    email                 {"test@example"}
    password              {"aaa000"}
    password_confirmation {password}
    family_name           {"田中"}
    first_name            {"太郎"}
    family_name_reading   {"タナカ"}
    first_name_reading    {"タロウ"}
    nickname              {"test"}
    birthday              {'1991-03-13'}
  end
end