# frozen_string_literal: true

module NylasV2
  # Ruby bindings for the Nylas Calendar API
  # @see https://docs.nylas.com/reference#calendars
  class Calendar
    include Model
    self.resources_path = "/calendars"
    allows_operations(listable: true, filterable: true, showable: true)

    attribute :id, :string
    attribute :account_id, :string

    attribute :object, :string

    attribute :name, :string
    attribute :description, :string
    attribute :is_primary, :boolean
    attribute :location, :string
    attribute :timezone, :string

    attribute :read_only, :boolean

    def read_only?
      read_only == true
    end

    def primary?
      is_primary
    end

    def events
      api.events.where(calendar_id: id)
    end
  end
end
