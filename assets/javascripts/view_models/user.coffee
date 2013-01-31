class @UserViewModel extends kendo.data.ObservableObject
  constructor: -> super @
  balance: []
  stocks: []
  formattedBalance: => formatPrice @get('balance')
  cost: (stock) -> stock.get('price') * stock.get('count')
  formattedCost: (stock) => formatPrice @cost(stock)
  totalCost: =>
    costs = @get('stocks').slice(0).map (stock) => @cost(stock)
    return 0 if costs.length == 0
    formatPrice costs.reduce (cost, sum) -> sum + cost
