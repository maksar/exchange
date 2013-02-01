class @UserPanelMediator
  constructor: (@panel, @channel, @viewModel) ->
    kendo.bind @panel, @viewModel
    @channel.onUserChange = @updateUser

  updateUser: (user) =>
    unless user
      @viewModel.set 'balance', 0
      @viewModel.set 'stocks', []
    @viewModel.set 'balance', user.balance
    @viewModel.set 'stocks', user.stocks