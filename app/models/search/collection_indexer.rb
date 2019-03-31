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
          },
          created_at: {
            type: "date"
          },
          title: {
            type: "text",
            fields: {
              keyword: { type: "keyword" }
            }
          }
        }
      }
    }
  end

  def document(object)
    owner_ids = object.owners.pluck(:id)
    moderator_ids = object.moderators.pluck(:id)

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
      unrevealed: object.unrevealed?,

      owner_ids: owner_ids,
      moderator_ids: moderator_ids,
      maintainer_ids: (owner_ids + moderator_ids).uniq
    )
  end
end
