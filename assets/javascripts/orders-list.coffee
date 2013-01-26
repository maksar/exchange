class OrdersTable
  constructor: (@table, @createOrderMediator, @confirmOrderMediator, @viewModel) ->
    @bindControls()
    @bindHandlers()

  bindControls: ->
    kendo.bind @table, @viewModel
    kendo.bind @table.find('#tableActions'),
      addOrder: @addOrder

  bindHandlers: -> @viewModel.action = @action

  action: (e) =>
    return @cancelOrder e.data if e.data.get('user') == window.currentUser
    @confirmOrderMediator.setOrder e.data
    @confirmOrderMediator.openWindow()

  addOrder: (e) =>
    @createOrderMediator.resetViewModel $(e.target).data('type')
    @createOrderMediator.openWindow()

  cancelOrder: (order) ->
    window.ws.send JSON.stringify
      action: formatActionName(order.get('user'), order.get('type')).toLowerCase()
      params:
        id: order.get('id')
        user: window.currentUser

  serialize: (e) ->

  clearOrders: ->
    @viewModel.set 'orders', []

  pushOrder: (order) ->
    @viewModel.get('orders').push order

  removeOrder: (order) ->
    orders = @viewModel.get('orders')
    orders.splice(index, 1) for o, index in orders when o.id == order.id


$ =>
  createOrderMediator = new CreateOrderMediator $('#createOrderForm'), @ws
  confirmOrderMediator = new ConfirmOrderMediator $('#confirmOrderForm'), @ws

  @ordersTable = new OrdersTable($('#example'), createOrderMediator, confirmOrderMediator, new OrdersListViewModel)
