# frozen_string_literal: true

require "json"
require "rest-client"

# BUGFIX
#   See https://github.com/sparklemotion/http-cookie/issues/27
#   and https://github.com/sparklemotion/http-cookie/issues/6
#
# CookieJar uses unsafe class caching for dynamically loading cookie jars
# If 2 rest-client instances are instantiated at the same time, (in threads)
# non-deterministic behaviour can occur whereby the Hash cookie jar isn't
# properly loaded and cached.
# Forcing an instantiation of the jar onload will force the CookieJar to load
# before the system has a chance to spawn any threads.
# Note this should technically be fixed in rest-client itself however that
# library appears to be stagnant so we're forced to fix it here
# This object should get GC'd as it's not referenced by anything
HTTP::CookieJar.new

require "ostruct"
require "forwardable"

require_relative "nylas_v2/version"
require_relative "nylas_v2/errors"

require_relative "nylas_v2/logging"
require_relative "nylas_v2/registry"
require_relative "nylas_v2/types"
require_relative "nylas_v2/constraints"

require_relative "nylas_v2/collection"
require_relative "nylas_v2/model"

# Attribute types supported by the API
require_relative "nylas_v2/email_address"
require_relative "nylas_v2/event"
require_relative "nylas_v2/event_collection"
require_relative "nylas_v2/file"
require_relative "nylas_v2/folder"
require_relative "nylas_v2/im_address"
require_relative "nylas_v2/label"
require_relative "nylas_v2/message_headers"
require_relative "nylas_v2/message_tracking"
require_relative "nylas_v2/participant"
require_relative "nylas_v2/physical_address"
require_relative "nylas_v2/phone_number"
require_relative "nylas_v2/recurrence"
require_relative "nylas_v2/rsvp"
require_relative "nylas_v2/timespan"
require_relative "nylas_v2/web_page"
require_relative "nylas_v2/nylas_date"
require_relative "nylas_v2/when"
require_relative "nylas_v2/free_busy"
require_relative "nylas_v2/time_slot"

# Custom collection types
require_relative "nylas_v2/search_collection"
require_relative "nylas_v2/deltas_collection"
require_relative "nylas_v2/free_busy_collection"

# Models supported by the API
require_relative "nylas_v2/account"
require_relative "nylas_v2/calendar"
require_relative "nylas_v2/contact"
require_relative "nylas_v2/contact_group"
require_relative "nylas_v2/current_account"
require_relative "nylas_v2/deltas"
require_relative "nylas_v2/delta"
require_relative "nylas_v2/draft"
require_relative "nylas_v2/message"
require_relative "nylas_v2/room_resource"
require_relative "nylas_v2/new_message"
require_relative "nylas_v2/raw_message"
require_relative "nylas_v2/thread"
require_relative "nylas_v2/webhook"

# Neural specific types
require_relative "nylas_v2/neural"
require_relative "nylas_v2/neural_sentiment_analysis"
require_relative "nylas_v2/neural_ocr"
require_relative "nylas_v2/neural_categorizer"
require_relative "nylas_v2/neural_clean_conversation"
require_relative "nylas_v2/neural_contact_link"
require_relative "nylas_v2/neural_contact_name"
require_relative "nylas_v2/neural_signature_contact"
require_relative "nylas_v2/neural_signature_extraction"
require_relative "nylas_v2/neural_message_options"
require_relative "nylas_v2/categorize"

require_relative "nylas_v2/native_authentication"

require_relative "nylas_v2/http_client"
require_relative "nylas_v2/api"

require_relative "nylas_v2/filter_attributes"
# an SDK for interacting with the Nylas API
# @see https://docs.nylas.com/reference
module NylasV2
  Types.registry[:account] = Types::ModelType.new(model: Account)
  Types.registry[:calendar] = Types::ModelType.new(model: Calendar)
  Types.registry[:contact] = Types::ModelType.new(model: Contact)
  Types.registry[:delta] = DeltaType.new
  Types.registry[:draft] = Types::ModelType.new(model: Draft)
  Types.registry[:email_address] = Types::ModelType.new(model: EmailAddress)
  Types.registry[:event] = Types::ModelType.new(model: Event)
  Types.registry[:file] = Types::ModelType.new(model: File)
  Types.registry[:folder] = Types::ModelType.new(model: Folder)
  Types.registry[:im_address] = Types::ModelType.new(model: IMAddress)
  Types.registry[:label] = Types::ModelType.new(model: Label)
  Types.registry[:room_resource] = Types::ModelType.new(model: RoomResource)
  Types.registry[:message] = Types::ModelType.new(model: Message)
  Types.registry[:message_headers] = MessageHeadersType.new
  Types.registry[:message_tracking] = Types::ModelType.new(model: MessageTracking)
  Types.registry[:participant] = Types::ModelType.new(model: Participant)
  Types.registry[:physical_address] = Types::ModelType.new(model: PhysicalAddress)
  Types.registry[:phone_number] = Types::ModelType.new(model: PhoneNumber)
  Types.registry[:recurrence] = Types::ModelType.new(model: Recurrence)
  Types.registry[:thread] = Types::ModelType.new(model: Thread)
  Types.registry[:timespan] = Types::ModelType.new(model: Timespan)
  Types.registry[:web_page] = Types::ModelType.new(model: WebPage)
  Types.registry[:nylas_date] = NylasDateType.new
  Types.registry[:contact_group] = Types::ModelType.new(model: ContactGroup)
  Types.registry[:when] = Types::ModelType.new(model: When)
  Types.registry[:time_slot] = Types::ModelType.new(model: TimeSlot)
  Types.registry[:neural] = Types::ModelType.new(model: Neural)
  Types.registry[:categorize] = Types::ModelType.new(model: Categorize)
  Types.registry[:neural_signature_contact] = Types::ModelType.new(model: NeuralSignatureContact)
  Types.registry[:neural_contact_link] = Types::ModelType.new(model: NeuralContactLink)
  Types.registry[:neural_contact_name] = Types::ModelType.new(model: NeuralContactName)
end
