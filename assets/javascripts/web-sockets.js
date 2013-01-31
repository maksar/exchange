$(function() {
  ws = new ReconnectingWebSocket("ws://" + location.hostname + ":8080/ws");
  ws.onclose = function(e) {
    ordersTable.clearOrders();
  }
  ws.onmessage = function(evt) {
    var data = JSON.parse(evt.data);
    for (var item in data.orders.change) {
      ordersTable.changeOrder(data.orders.change[item]);
    }
    for (var item in data.orders.add) {
      ordersTable.pushOrder(data.orders.add[item]);
    }
    for (var item in data.orders.remove) {
      ordersTable.removeOrder(data.orders.remove[item]);
    }

    userPanel.updateUser(data.user);
  }
});