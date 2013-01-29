module Observable
  [:add, :remove, :change].each do |message|
    class_eval <<-RUBY
      def subscribe_#{message} block
        @handlers_#{message} ||= []
        @handlers_#{message} << block
      end

      protected

      def notify_#{message} change
        execute @handlers_#{message}, change
      end
    RUBY
  end

  private

  def execute handlers, change
    (handlers || []).each do |handler|
      handler.call(change)
    end
  end
end