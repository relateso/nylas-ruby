# frozen_string_literal: true

module NylasV2
  # Structure to represent the Label Schema
  # @see https://docs.nylas.com/reference#labels
  class Label
    include Model
    self.resources_path = "/labels"
    self.creatable = true
    self.listable = true
    self.showable = true
    self.filterable = false
    self.updatable = true
    self.destroyable = true

    attribute :id, :string
    attribute :account_id, :string

    attribute :object, :string

    attribute :name, :string
    attribute :display_name, :string
  end
end
