FactoryBot.define do
  factory :image do
    image  {Rack::Test::UploadedFile.new(File.join(Rails.root,'app/assets/images/close.png'))}
  end
end