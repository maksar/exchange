class @Window
  constructor: (@element, params) ->
    @window = @element.data "kendoWindow"
    @window ?= @element.kendoWindow(params).data "kendoWindow"
  open: ->
    @window.center()
    @window.open()
  close: ->
    @window.close()
