module Observable
  # TODO to a.shestakov Generalize
  def subscribe_add block
    @handlers_add ||= []
    @handlers_add << block
  end

  def subscribe_remove block
    @handlers_remove ||= []
    @handlers_remove << block
  end

  def subscribe_change block
    @handlers_change ||= []
    @handlers_change << block
  end

  protected

  def notify_add change
    execute @handlers_add, change
  end

  def notify_remove change
    execute @handlers_remove, change
  end

  def notify_change change
    execute @handlers_change, change
  end

  private

  def execute handlers, change
    (handlers || []).each do |handler|
      handler.call(change)
    end
  end
end