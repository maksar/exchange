class @Channel
  constructor: (url) ->
    @socket = new ReconnectingWebSocket url
    @socket.onclose = @onClose
    @socket.onmessage = @onMessage

  onClose: =>
    @onOrdersClear()
    @onUserChange null

  onMessage: (event) =>
    data = JSON.parse event.data

    @onOrderChange item for item in data.orders.change
    @onOrderAdd item for item in data.orders.add
    @onOrderRemove item for item in data.orders.remove

    @onUserChange data.user

  send: (data) ->
    @socket.send data