module LogService
  class Create
    def self.call(msg, status = "info", locate = "my.log")
      new(msg, status, locate).call
    end

    def call
      log ||= Logger.new("#{Rails.root}/log/#{locate}")
      log.send(status) do
        msg
      end
    end

    private
      def initialize(msg, status, locate)
        @status = status
        @msg = msg
        @locate = locate
      end

      attr_reader(:status, :msg, :locate)
  end
end
