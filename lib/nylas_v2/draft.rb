# frozen_string_literal: true

module NylasV2
  # Ruby representatin of a Nylas Draft object
  # @see https://docs.nylas.com/reference#drafts
  class Draft
    include Model
    self.resources_path = "/drafts"
    allows_operations(creatable: true, showable: true, listable: true, updatable: true, destroyable: true)

    attribute :id, :string
    attribute :object, :string
    attribute :version, :integer
    attribute :account_id, :string
    attribute :thread_id, :string
    attribute :reply_to_message_id, :string

    has_n_of_attribute :to, :email_address
    has_n_of_attribute :from, :email_address
    has_n_of_attribute :cc, :email_address
    has_n_of_attribute :bcc, :email_address
    has_n_of_attribute :reply_to, :email_address

    attribute :date, :unix_timestamp
    attribute :subject, :string
    attribute :snippet, :string
    attribute :body, :string
    attribute :starred, :boolean
    attribute :unread, :boolean

    has_n_of_attribute :events, :event
    has_n_of_attribute :files, :file, read_only: true
    has_n_of_attribute :file_ids, :string
    attribute :folder, :folder
    has_n_of_attribute :labels, :label

    attribute :tracking, :message_tracking

    transfer :api, to: %i[events files folder labels]

    def update(**data)
      self.files = data[:files] if data[:files]
      extract_file_ids!
      data[:file_ids] = file_ids

      super
    end

    def create
      extract_file_ids!

      super
    end

    def send!
      return execute(method: :post, path: "/send", payload: to_json) if tracking

      save
      execute(method: :post, path: "/send", payload: JSON.dump(draft_id: id, version: version))
    end

    def starred?
      starred
    end

    def unread?
      unread
    end

    def destroy
      execute(method: :delete, path: resource_path, payload: attributes.serialize_for_api(keys: [:version]))
    end

    private

    def save_call
      extract_file_ids!

      super
    end

    def extract_file_ids!
      files = self.files || []

      self.file_ids = files.map(&:id)
    end
  end
end
