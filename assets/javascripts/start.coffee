$ =>
  createOrderMediator = new CreateOrderMediator $('#createOrderForm'), @ws
  confirmOrderMediator = new ConfirmOrderMediator $('#confirmOrderForm'), @ws

  @ordersTable = new OrdersTableMediator($('#example'), createOrderMediator, confirmOrderMediator, new OrdersListViewModel)

  @userPanel = new UserPanelMediator($('#user-panel'), new UserViewModel)
