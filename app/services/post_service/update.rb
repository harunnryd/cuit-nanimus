module PostService
  class Update
    def self.call(current_post, attrs, callbacks)
      new(current_post, attrs, callbacks).call
    end

    def call
      post = current_post
      post = PostValidator::Update.validate(post, attrs)
      if post.errors.any?
        LogService::Create.call(post, 'error', 'post.log')
        return callbacks[:failure].call(post)
      end
      post.title = attrs.fetch(:title)
      post.content = attrs.fetch(:content)
      post.photo = attrs.fetch(:photo)
      if post.save
        LogService::Create.call(post, 'info', 'post.log')
        return callbacks[:success].call
      end
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
