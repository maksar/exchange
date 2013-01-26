$(function() {
  ws = new ReconnectingWebSocket("ws://" + location.hostname + ":8080/ws");
  ws.onclose = function(e) {
    ordersTable.clearOrders();
  }
  ws.onmessage = function(evt) {
    var data = JSON.parse(evt.data);
    for (var item in data.add) {
      ordersTable.pushOrder(data.add[item]);
    }
    for (var item in data.remove) {
      ordersTable.removeOrder(data.remove[item]);
    }
  }

});