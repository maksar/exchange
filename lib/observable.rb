module Observable
  def subscribe_add block
    @handlers_add ||= []
    @handlers_add << block
  end

  def subscribe_remove block
    @handlers_remove ||= []
    @handlers_remove << block
  end

  protected

  def notify_add change
    execute @handlers_add, change
  end

  def notify_remove change
    execute @handlers_remove, change
  end

  private

  def execute handlers, change
    (handlers || []).each do |handler|
      handler.call(change)
    end
  end
end