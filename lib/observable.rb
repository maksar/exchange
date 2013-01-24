module Observable
  def subscribe_add &block
    @handler_add = block
  end

  def subscribe_remove &block
    @handler_remove = block
  end

  private

  def notify_add change
    @handler_add.call(change) if @handler_add
  end

  def notify_remove change
    @handler_remove.call(change) if @handler_remove
  end
end