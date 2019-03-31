class CollectionSearchForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  ATTRIBUTES = [
    :title,
    :fandom,
    :closed,
    :moderated,
    :challenge_type,
  ]

  attr_accessor :options

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

  def search_results
    @searcher.search_results
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

  def sort_column
    options[:sort_column] || default_sort_column
  end

  def sort_direction
    options[:sort_direction] || default_sort_direction
  end

  def default_sort_column
    "title"
  end

  def default_sort_direction
    if %w[title].include?(sort_column)
      "asc"
    else
      "desc"
    end
  end
end
