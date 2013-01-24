$(function() {
  viewModel = kendo.observable({
    orders: [],
    addOrder: function (e) {
      newOrderViewModel.set('type', $(e.target).data('type'));
      newOrderViewModel.set('stock', null);
      newOrderViewModel.set('count', null);
      newOrderViewModel.set('price', null);

      this.showWindow();
    },
    showWindow: function() {
      var window = $('#window').data("kendoWindow");

      if (!window) {
        window = $('#window').kendoWindow({
          width: "250px",
          title: "New Order",
          modal: true
        }).data("kendoWindow");
      }
      window.center();
      window.open();

    },
    action: function(e) {
      ws.send(JSON.stringify({action: formatActionName(e.data.user, e.data.type).toLowerCase(), params: {id: e.data.id, user: window.currentUser}}));
    },
    formattedActionName: function(order) {
      return formatActionName(order.user, order.type);
    },
    formattedPrice: function(order) {
      return kendo.toString(order.price, 'c');
    },
    formattedOrderType: function(order) {
      return formatOrderType(order.type);
    }
  })
kendo.bind($("#example"), viewModel);
});