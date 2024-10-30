# frozen_string_literal: true

module NylasV2
  # Structure to represent the IM Address Schema
  # @see https://docs.nylas.com/reference#contactsid
  class IMAddress
    include Model::Attributable
    attribute :type, :string
    attribute :im_address, :string
  end
end
