FactoryGirl.define do
  factory :item do
    size { ['S', 'M', 'L', 'venti'].sample }
    color { FFaker::Color.name }
    status { ['sold', 'unsold'].sample }
    product
  end
end
