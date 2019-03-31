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

  def sort
    direction = options[:sort_direction]&.downcase
    case options[:sort_column]
    when "collections.created_at"
      column = "created_at"
      direction ||= "desc"
    else
      column = "title.keyword"
      direction ||= "asc"
    end

    { column => { order: direction } }
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
