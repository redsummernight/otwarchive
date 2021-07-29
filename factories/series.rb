require "faker"

FactoryBot.define do
  sequence(:series_title) do |n|
    "Awesome Series #{n}"
  end

  factory :serial_work do
    work
  end

  factory :series do
    title { generate(:series_title) }
    works { [create(:work)] }

    after(:build) do |series|
      series.works.first.pseuds.each do |pseud|
        series.creatorships.build(pseud: pseud)
      end
    end
  end
end
