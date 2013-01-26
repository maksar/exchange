$(function() {
  ws = new ReconnectingWebSocket("ws://localhost:8080/ws");
  ws.onclose = function(e) {
    viewModel.set('orders', []);
  }
  ws.onmessage = function(evt) {
    var data = JSON.parse(evt.data);
    for (var item in data.add) {
      viewModel.get('orders').push(data.add[item]);
      viewModel.set('orders', viewModel.get('orders'));
    }
    for (var item in data.remove) {
      for (var elem in viewModel.get('orders')) {
        if (viewModel.get('orders')[elem].id == data.remove[item].id) {
          viewModel.get('orders').splice(elem, 1);
        }
      }
    }
  }

});