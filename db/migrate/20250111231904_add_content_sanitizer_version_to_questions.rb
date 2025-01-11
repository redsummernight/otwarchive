class AddContentSanitizerVersionToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :content_sanitizer_version, :integer, default: 0, null: false, limit: 2
  end
end
