$(function() {
  $(".currency").kendoNumericTextBox({format: "c"});
  $(".amount").kendoNumericTextBox({format: "0"});

  kendo.bind($('#window'), kendo.observable({
    type: null,
    stock: null,
    count: null,
    price: null,

    orderType: function() {
      return formatOrderType(this.get('type'));
    },

    createOrder: function(e) {
      var validator = $("#window").kendoValidator({validateOnBlur: false}).data("kendoValidator");
      if (validator.validate()) {
        for (var i=0; i<=1000; i++) {
          ws.send(JSON.stringify({action: 'createOrder', params: this.toJSON()}));
        }
        $('#window').data("kendoWindow").close();
      }
    }
  }));
});

