# frozen_string_literal: true

# Caches the timestamp of the last change for every user.
# This can be used to set the Last-Modified HTTP header
# without having to make an additional database query.
module CacheablePerUser
  extend ActiveSupport::Concern

  included do
    after_commit do
      Rails.cache.write(self.class.last_modified_at_cache_key(user_id), Time.zone.now.to_i)
    end
  end

  class_methods do
    def last_modified_at_for(user_id)
      timestamp = Rails.cache.read(last_modified_at_cache_key(user_id))
      return unless timestamp

      Time.zone.at(timestamp.to_i)
    end

    def last_modified_at_cache_key(user_id)
      "users/#{user_id}/#{model_name.plural}/last_modified_at"
    end
  end
end
