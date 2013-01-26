class OrdersTable
  constructor: (@table, @socket, @viewModel) ->
    @bindControls()
    @bindHandlers()

  bindControls: ->
    kendo.bind @table, @viewModel
    kendo.bind @table.find('#tableActions'),
      addOrder: @addOrder

  bindHandlers: -> @viewModel.action = @action

  action: (e) => @socket.send @serialize e

  addOrder: (e) =>
    orderForm.viewModel.set 'type', $(e.target).data('type')
    orderForm.viewModel.set 'stock', null
    orderForm.viewModel.set 'count', null
    orderForm.viewModel.set 'price', null

    orderWindow.open()

  serialize: (e) -> JSON.stringify
    action: formatActionName(e.data.user, e.data.type).toLowerCase()
    params:
      id: e.data.id
      user: window.currentUser

class OrdersListViewModel extends kendo.data.ObservableObject
  constructor: -> super @
  orders: []
  formattedActionName: (order) -> formatActionName order.user, order.type
  formattedPrice: (order) -> kendo.toString order.price, 'c'
  formattedOrderType: (order) -> formatOrderType order.type

$ ->
  window.viewModel = new OrdersListViewModel()
  window.aaa = new OrdersTable($('#example'), window.ws, window.viewModel)
