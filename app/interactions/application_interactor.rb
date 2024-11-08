# frozen_string_literal: true

class ApplicationInteractor < ActiveInteraction::Base
  include ActiveInteraction::Extras::All
  set_callback :execute, :around, :catch_errors

  def run!
    run

    raise InteractionError, errors unless valid?

    result
  end

  def catch_errors
    yield
  rescue ActiveRecord::RecordInvalid => e
    errors.merge! e.record.errors
  rescue StandardError => e
    errors.add(:base, e.message.presence || 'Undefined Error')
  end

  class InteractionError < StandardError
    attr_reader :errors, :message

    def initialize(errors)
      super
      @message = errors.full_messages.first
      @errors = errors
    end
  end

  def logger
    @logger ||= Rails.logger.tagged(self)
  end
end
