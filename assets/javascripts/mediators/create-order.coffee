class @CreateOrderMediator
  constructor: (@element, @socket) ->
    @window = @createWindow()
    @form = @createForm()

  createWindow: ->
    new Window @element,
      width: "250px"
      title: "New Order"
      modal: true

  createForm: ->
    new CreateOrderForm(@element, @socket, @window, new CreateOrderViewModel)

  resetViewModel: (type) ->
    @form.viewModel.set 'type', type
    @form.viewModel.set 'stock', null
    @form.viewModel.set 'count', null
    @form.viewModel.set 'price', null

  openWindow: ->
    @window.open()

