class CollectionIndexer < Indexer
  def self.klass
    "Collection"
  end

  def self.mapping
    {
      collection: {
        properties: {
          challenge_type: {
            type: "keyword"
          }
        }
      }
    }
  end

  def document(object)
    object.as_json(
      root: false,
      only: %i[
        id name title description created_at
        parent_id challenge_type
      ]
    ).merge(
      anonymous: object.anonymous?,
      closed: object.closed?,
      moderated: object.moderated?,
      unrevealed: object.unrevealed?
    )
  end
end
