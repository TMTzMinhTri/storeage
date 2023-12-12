class ApplicationService
  attr_reader :errors, :result

  def initialize(*)
    @errors = []
    @result = nil
  end

  def success?
    errors.blank?
  end

  def errors_add(message)
    @errors ||= []

    if message.is_a?(Array)
      @errors += message
    elsif message.is_a?(ActiveModel::Errors)
      message.each do |key, errors_message|
        @errors << {
          reason: key.to_s,
          message: errors_message
        }
      end
    else
      @errors << message
    end
  end

  class << self
    def call(**args)
      service = new(**args)
      service.call
      service
    end
  end
end
