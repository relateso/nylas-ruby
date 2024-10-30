# frozen_string_literal: true

module NylasV2
  # Ensures our search requests hit the right path
  class SearchCollection < Collection
    def resources_path
      "#{model.resources_path(api: api)}/search"
    end
  end
end
