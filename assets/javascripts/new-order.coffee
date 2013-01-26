class Validator
  constructor: (element) ->
    @validator = element.kendoValidator(validateOnBlur: false).data("kendoValidator")
  validate: ->
    @validator.validate()

class OrderViewModel extends kendo.data.ObservableObject
  constructor: -> super @
  type: 'sell'
  stock: null
  count: null
  price: null
  orderType: => formatOrderType @get('type')

class OrderForm
  constructor: (@form, @socket, @window, @viewModel) ->
    @initEditBoxes()
    @bindControls()

  initEditBoxes: ->
    @form.find(".currency").kendoNumericTextBox
      format: "c"
    @form.find(".amount").kendoNumericTextBox
      format: "0"

  bindControls: ->
    kendo.bind @form.find('form'), @viewModel
    kendo.bind @form.find('#formActions'),
      createOrder: @createOrder

  validate: ->
    (@validator ?= new Validator(@form)).validate()

  createOrder: =>
    if @validate()
      @socket.send @serialize()
      @window.close()

  serialize: =>
    JSON.stringify
      action: 'createOrder'
      params: @viewModel.toJSON()

class Window
  constructor: (@element, params) ->
    @window = @element.data "kendoWindow"
    @window ?= @element.kendoWindow(params).data "kendoWindow"
  open: ->
    @window.center()
    @window.open()
  close: ->
    @window.close()

$ =>
  @orderWindow = new Window $('#createOrderForm'),
    width: "250px",
    title: "New Order",
    modal: true


  @orderForm = new OrderForm($('#createOrderForm'), window.ws, @orderWindow, new OrderViewModel())



