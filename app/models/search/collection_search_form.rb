class CollectionSearchForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  ATTRIBUTES = [
    :title,
    :fandom,
    :closed,
    :moderated,
    :challenge_type
  ]

  attr_accessor :options

  delegate :sort_column, :sort_direction, :search_results,
           to: :@searcher

  ATTRIBUTES.each do |filterable|
    define_method(filterable) { options[filterable] }
  end

  def initialize(options = {})
    @options = options
    @searcher = CollectionQuery.new(@options.delete_if { |_, v| v.blank? })
  end

  def persisted?
    false
  end

  ###############
  # SORTING
  ###############

  def sort_options
    [
      ["Title", "title"],
      ["Date Created", "created_at"],
    ]
  end
end
