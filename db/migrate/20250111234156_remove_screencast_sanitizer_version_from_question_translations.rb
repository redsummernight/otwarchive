class RemoveScreencastSanitizerVersionFromQuestionTranslations < ActiveRecord::Migration[7.0]
  def change
    remove_column :question_translations, :screencast_sanitizer_version, :integer, default: 0, null: false, limit: 2
  end
end
