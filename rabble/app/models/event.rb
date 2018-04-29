class Event < ApplicationRecord
  belongs_to :group, optional: true
end
