class RouteSerializer
  include JSONAPI::Serializer

  attribute :id
  attribute :name

  has_many :stations
end
