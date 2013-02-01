$ =>
  @channel = new Channel "ws://#{location.hostname}:8080/ws"

  createOrderMediator = new CreateOrderMediator $('#createOrderForm'), @channel.socket
  confirmOrderMediator = new ConfirmOrderMediator $('#confirmOrderForm'), @channel.socket

  @ordersTable = new OrdersTableMediator($('#example'), @channel, createOrderMediator, confirmOrderMediator, new OrdersListViewModel)

  @userPanel = new UserPanelMediator $('#user-panel'), @channel, new UserViewModel
