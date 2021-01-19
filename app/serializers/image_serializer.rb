class ImageSerializer
  include JSONAPI::Serializer
  attributes :location, :image_url, :credit
end
