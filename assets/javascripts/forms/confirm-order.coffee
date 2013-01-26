class @ConfirmOrderForm extends OrderForm
  constructor: (args...) ->
    super args...
    @restrictMaxCount()

  restrictMaxCount: ->
    @amountEdit.bind 'spin', (e) => @viewModel.set 'count', e.sender.value()
    @viewModel.bind 'change', (e) => @amountEdit.max(@viewModel.get('order.count')) if e.field == 'order'

  request: ->
    action: 'confirmOrder'
    params:
      id: @viewModel.get('order.id')
      count: @viewModel.get('count')
