module CacheHelper
  def cache_key_for_all(klass_name)
    klass = klass_name.to_s.singularize.capitalize.constantize
    count = klass.count
    max_updated_at = klass.maximum(:updated_at).try(:utc).try(:to_s, :number)
    page = params[:page]
    "#{current_subdomain}/#{klass_name}/all-page#{page}-#{count}-#{max_updated_at}"
  end

  def static_cache_key_for(key)
    [Hours.cache_id, key.to_s].join("/")
  end

  # returns a cache key for the object
  # and differentiates between wether
  # the objects which user attribute
  # is the current_user or not
  def cache_key_for_current_user(obj)
    [obj, (obj.user == current_user)]
  end
end
