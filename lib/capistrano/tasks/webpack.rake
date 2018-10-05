# frozen_string_literal: true

namespace :webpack do
  desc 'Compile JavaScript packs using webpack for production with digests'
  task :compile do
    on roles(:all) do
      within release_path do
        with(
          rails_env: fetch(:rails_env),
          rails_relative_url_root: fetch(:webpack_rails_relative_url_root)
        ) do
          execute :rails, 'webpacker:compile'
        end
      end
    end
  end
end
