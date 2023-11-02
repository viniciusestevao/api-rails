class UserToken < ApplicationRecord
    belongs_to :user

    scope :valid, -> { where('expires_at > ?', Time.zone.now) }
end
