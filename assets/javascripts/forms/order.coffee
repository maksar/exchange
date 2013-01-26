class @OrderForm
  constructor: (@form, @socket, @window, @viewModel) ->
    @initEditBoxes()
    @bindControls()

  initEditBoxes: ->
    @priceEdit = @form.find(".currency").kendoNumericTextBox(
      format: "c").data 'kendoNumericTextBox'
    @amountEdit = @form.find(".amount").kendoNumericTextBox(
      format: "0").data 'kendoNumericTextBox'

  bindControls: ->
    kendo.bind @form.find('form'), @viewModel
    kendo.bind @form.find('#formActions'),
      createOrder: @createOrder
      cancel: => @window.close()

  validate: ->
    (@validator ?= new Validator(@form)).validate()

  createOrder: =>
    if @validate()
      @socket.send @serialize()
      @window.close()

  serialize: =>
    JSON.stringify @request()