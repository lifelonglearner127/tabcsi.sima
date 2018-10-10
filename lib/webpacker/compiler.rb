# frozen_string_literal: true

module Webpacker
  class Compiler
    private

    def watched_files_digest
      return @watched_files_digest if @watched_files_digest.present?

      files =
        Dir[*default_watched_paths, *watched_paths]
        .reject { |f| File.directory?(f) }

      file_ids =
        files.sort.map do |f|
          "#{File.basename(f)}/#{Digest::SHA1.file(f).hexdigest}"
        end

      @watched_files_digest = Digest::SHA1.hexdigest(file_ids.join('/'))
    end
  end
end
