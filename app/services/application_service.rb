class ApplicationService
  attr_reader :errors, :result

  def initialize(*)
    @errors = []
    @result = nil
  end

  def success?
    errors.blank?
  end

  class << self
    def call(**args)
      service = new(**args)
      service.call
      service
    end
  end
end
