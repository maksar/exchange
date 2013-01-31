class Change
  def initialize orders, user
    @orders = orders
    @user = user
  end

  def add
    {
      user: {
        balance: @user.balance,
        stocks: @user.stocks
      },
      orders: {
        add: @orders,
        remove: [],
        change: []
      }
    }.to_json
  end

  def remove
    {
      user: {
        balance: @user.balance,
        stocks: @user.stocks
      },
      orders: {
        add: [],
        remove: @orders,
        change: []
      }
    }.to_json
  end

  def change
    {
      user: {
        balance: @user.balance,
        stocks: @user.stocks
      },
      orders: {
        add: [],
        remove: [],
        change: @orders
      }
    }.to_json
  end
end
