class @UserPanelMediator
  constructor: (@panel, @viewModel) ->
    kendo.bind @panel, @viewModel

  updateUser: (user) ->
    @viewModel.set 'balance', user.balance
    @viewModel.set 'stocks', user.stocks