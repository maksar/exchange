class @ConfirmOrderViewModel extends kendo.data.ObservableObject
  constructor: -> super @
  count: 1
  order: []
  totalPrice: -> formatPrice @get('count') * @get('order.price')
  formattedActionName: -> formatActionName(@get('order.user'), @get('order.type')) + ":"

