class @CreateOrderViewModel extends kendo.data.ObservableObject
  constructor: -> super @
  type: null
  stock: null
  count: null
  price: null
  orderType: => formatOrderType @get('type')
