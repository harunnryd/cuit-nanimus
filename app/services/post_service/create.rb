module PostService
  class Create
    def self.call(current_user, attrs, callbacks)
      new(current_user, attrs, callbacks).call
    end

    def call
      post = current_user.posts.new
      # ----------------------
      # NOTE : post validator
      # ----------------------
      post = PostValidator::Create.validate(post, attrs)
      if post.errors.any?
        LogService::Create.call(post, 'error', 'post.log')
        return callbacks[:failure].call(post)
      end
      post.title = attrs.fetch(:title)
      post.photo = attrs.fetch(:photo)
      post.content = attrs.fetch(:content)
      # ----------------------
      # NOTE : post condition
      # ----------------------
      if post.save
        LogService::Create.call(post, 'info', 'post.log')
        return callbacks[:success].call
      end
    end

    private
      def initialize(current_user, attrs, callbacks)
        @current_user = current_user
        @callbacks = callbacks
        @attrs = attrs
      end

      attr_reader(:current_user, :attrs, :callbacks)
  end
end
