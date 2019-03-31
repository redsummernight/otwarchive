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
    [].compact
  end

  def queries
    [].compact
  end

  def sort
  end

  ################
  # FILTERS
  ################

  ################
  # QUERIES
  ################
end
