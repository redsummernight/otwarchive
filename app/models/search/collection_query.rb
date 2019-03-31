class CollectionQuery < Query
  def klass
    "Collection"
  end

  def index_name
    CollectionIndexer.index_name
  end

  def document_type
    CollectionIndexer.document_type
  end

  def filters
    [
      collection_filter,
      maintainer_filter
    ].compact
  end

  def queries
    [].compact
  end

  ################
  # SORTING
  ################

  def sort_column
    @sort_column ||=
      options[:sort_column].present? ? options[:sort_column] : default_sort_column
  end

  def sort_direction
    @sort_direction ||=
      options[:sort_direction].present? ? options[:sort_direction] : default_sort_direction
  end

  def default_sort_column
    "created_at"
  end

  def default_sort_direction
    if %w[title].include?(sort_column)
      "asc"
    else
      "desc"
    end
  end

  def sort
    column = sort_column
    column = "title.keyword" if column == "title"
    { column => { order: sort_direction } }
  end

  ################
  # FILTERS
  ################

  def collection_filter
    term_filter(:parent_id, options[:collection_id]) if options[:collection_id].present?
  end

  def maintainer_filter
    terms_filter(:maintainer_ids, options[:maintainer_ids]) if options[:maintainer_ids].present?
  end

  ################
  # QUERIES
  ################
end
