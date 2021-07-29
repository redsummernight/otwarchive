FactoryBot.define do
  factory :bookmark do
    association :bookmarkable, factory: :work
    pseud

    factory :external_work_bookmark do
      association :bookmarkable, factory: :external_work
    end

    factory :series_bookmark do
      association :bookmarkable, factory: :series
    end
  end
end
