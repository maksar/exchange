class Validator
  constructor: (element) ->
    @validator = element.kendoValidator(validateOnBlur: false).data("kendoValidator")
  validate: ->
    @validator.validate()

class Order extends kendo.data.ObservableObject
  constructor: (window, socket) ->
    @window = -> window
    @socket = -> socket
    super @
  type: null
  stock: null
  count: null
  price: null
  orderType: -> formatOrderType @get('type')
  createOrder: (e) ->
    if (new Validator(@window())).validate()
      @socket().send JSON.stringify
        action: 'createOrder'
        params: @toJSON()
      @window().data('kendoWindow').close()

$ =>
  $(".currency").kendoNumericTextBox
    format: "c"
  $(".amount").kendoNumericTextBox
    format: "0"

   @newOrderViewModel = new Order($('#window'), @ws)
   kendo.bind($('#window'), @newOrderViewModel);
