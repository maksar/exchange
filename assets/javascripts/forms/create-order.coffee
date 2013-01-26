class @CreateOrderForm extends OrderForm
  constructor: (args...) -> super args...
  request: ->
    action: 'createOrder'
    params: @viewModel.toJSON()
