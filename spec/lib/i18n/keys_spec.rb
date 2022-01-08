require "i18n/tasks"

RSpec.describe I18n do
  let(:i18n) { I18n::Tasks::BaseTask.new }
  let(:inconsistent_interpolations) { i18n.inconsistent_interpolations }

  it "does not have inconsistent interpolations" do
    puts inconsistent_interpolations.inspect
    error_message = "#{inconsistent_interpolations.leaves.count} i18n keys have inconsistent interpolations."
    expect(inconsistent_interpolations).to be_empty, error_message
  end
end
