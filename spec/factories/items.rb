FactoryGirl.define do
  factory :item do
    color { FFaker::Color.name }
    size "M"
    status { ["sold", "unsold"].sample }
  end
end
