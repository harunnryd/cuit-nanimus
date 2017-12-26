module PostService
  class Delete
    def self.call(current_post, attrs, callbacks)
      new(current_post, attrs, callbacks).call
    end

    def call
      post = current_post.destroy
      if post.save
        LogService::Create.call(post, 'info', 'post.log')
        return callbacks[:success].call
      end
      LogService::Create.call(post, 'error', 'post.log')
      return callbacks[:failure].call
    end

    private
      def initialize(current_post, attrs, callbacks)
        @current_post = current_post
        @attrs = attrs
        @callbacks = callbacks
      end

      attr_reader(:current_post, :attrs, :callbacks)
  end
end
