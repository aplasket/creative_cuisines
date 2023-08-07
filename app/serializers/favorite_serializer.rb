class FavoriteSerializer
  include JSONAPI::Serializer

  set_id :id
  set_type :favorite
  attributes  :country,
              :recipe_link,
              :recipe_title,
              :created_at
end