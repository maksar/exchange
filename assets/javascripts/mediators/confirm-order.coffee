class @ConfirmOrderMediator
  constructor: (@element, @socket) ->
    @window = @createWindow()
    @form = @createForm()

  createWindow: ->
    new Window @element,
      width: "300px"
      title: "Confirm Order"
      modal: true

  createForm: ->
    new ConfirmOrderForm(@element, @socket, @window, new ConfirmOrderViewModel)

  setOrder: (order) ->
    @form.viewModel.set 'order', order
    @form.viewModel.set 'count', order.get('count')

  openWindow: ->
    @window.open()

