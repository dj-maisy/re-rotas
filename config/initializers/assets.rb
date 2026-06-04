# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join("node_modules")

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w[admin.js admin.css]

# This is to get govuk-frontend images / fonts
Rails.application.config.assets.paths << Rails.root.join(
  "node_modules/govuk-frontend/govuk/assets",
)

# This is to get govuk-frontend css / js
Rails.application.config.assets.paths << Rails.root.join(
  "node_modules/govuk-frontend/govuk",
)

# Sprockets 4 does not support Regexp in precompile; use explicit globs instead.
# Rails needs to know about the file extensions for our fonts
Rails.application.config.assets.precompile += %w[*.svg *.eot *.woff *.woff2 *.ttf *.ico]
