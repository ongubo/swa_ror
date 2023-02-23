class ElectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :election_day, :division,:created_at
end
