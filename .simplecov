SimpleCov.start "rails" do
  add_filter "/factories/"
  merge_timeout 7200
  command_name ENV["TEST_GROUP"].gsub(/[^\w]/, "_") if ENV["TEST_GROUP"]

  if ENV["CI"] == "true"
    require "codecov"
    SimpleCov.formatter = SimpleCov::Formatter::Codecov
  end
end
