require "cucumber/rspec/doubles"
require "cucumber/timecop"
require "email_spec/cucumber"

Before do
  # Enable our experimental caching, skipping validations which require
  # setting an admin as the last updater.
  AdminSetting.first.update_attribute(:enable_test_caching, true)

  # TODO: "Not Rated" should be adult, to match the behavior in production, but
  # there are many tests that rely on being able to view a "Not Rated" work
  # without clicking through the adult content warning. So until those tests
  # are fixed, we leave "Not Rated" as a non-adult rating.
  Rating.find_by!(name: ArchiveConfig.RATING_DEFAULT_TAG_NAME).update_attribute(:adult, false)

  # Clears used values for all generators.
  Faker::UniqueGenerator.clear

  # Reset global locale setting.
  I18n.locale = I18n.default_locale

  # Assume all spam checks pass by default.
  allow(Akismetor).to receive(:spam?).and_return(false)

  # Reset the current user:
  User.current_user = nil

  # Clear Memcached
  Rails.cache.clear

  # Remove old tag feeds
  page_cache_dir = Rails.root.join("public/test_cache")
  FileUtils.remove_dir(page_cache_dir, true) if Dir.exist?(page_cache_dir)

  # Clear Redis
  REDIS_AUTOCOMPLETE.flushall
  REDIS_GENERAL.flushall
  REDIS_HITS.flushall
  REDIS_KUDOS.flushall
  REDIS_RESQUE.flushall
  REDIS_ROLLOUT.flushall

  Indexer.all.map(&:prepare_for_testing)
end

After do
  Indexer.all.map(&:delete_index)
end

@javascript = false
Before "@javascript" do
  @javascript = true
end

Before "@disable_caching" do
  ActionController::Base.perform_caching = false
end

After "@disable_caching" do
  ActionController::Base.perform_caching = true
end

Before "@skins" do
  # Create a default skin:
  AdminSetting.current.update_attribute(:default_skin, Skin.default)
end
