# frozen_string_literal: true

namespace :tabc_si do
  desc(
    'Set the atime and mtime of all repo files based on the most recent' \
    ' (relative to each file) commit author date.'
  )
  task :set_mtimes do
    on release_roles :all do
      within repo_path do
        with fetch(:git_environmental_variables) do
          # Everything is done in a single `execute` to avoid numerous SSH
          # connections (one per file plus one to get the list of files).
          #
          # Because Capistrano uses `/usr/bin/env`, we need to "break out" of
          # that by giving it a command name and redirecting output to the null
          # device. `:echo` seems like the simplest and safest choice here.
          #
          # And because of SSHKit's `Symbol` quirk, the first argument must be a
          # `Symbol` to ensure `within` and `with` apply to the loop.
          execute(
            :echo, '> /dev/null ;', <<~CMD
              for path in $(git ls-tree --name-only -r "#{fetch(:branch)}"); do
                touch -t $(git log -1 --format=%ad --date=format:%Y%m%d%H%M.%S "#{fetch(:branch)}" -- "${path}") "#{release_path}/${path}"
              done
            CMD
          )
        end
      end
    end
  end

  desc 'Remove the current release.'
  task :remove_current_release do
    on roles :app do
      execute "rm -fr #{release_path}"
    end
  end
end
