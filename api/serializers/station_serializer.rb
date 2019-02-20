class StationSerializer
  include JSONAPI::Serializer

  attribute :id
  attribute :name

  has_many :trains
end
