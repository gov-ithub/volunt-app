# https://www.postgresql.org/docs/9.1/static/unaccent.html
class AddUnaccentExtension < ActiveRecord::Migration[5.0]
  def up
    # This requires superuser. If it fails with permission problems,
    # thou shall enable unaccent manually and then run the migration which will be a no-op
    enable_extension :unaccent unless extension_enabled?(:unaccent)
  end

  def down
    # If you wish to disable the unaccent extension, do it so manually
    # removing it is problematic due to superuser requirements
  end

end
