class @OrdersListViewModel extends kendo.data.ObservableObject
  constructor: -> super @
  orders: []
  formattedActionName: (order) -> formatActionName order.get('user'), order.get('type')
  formattedPrice: (order) -> formatPrice order.get('price')
  formattedOrderType: (order) -> formatOrderType order.get('type')
