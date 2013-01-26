class @Validator
  constructor: (element) ->
    @validator = element.kendoValidator(validateOnBlur: false).data("kendoValidator")
  validate: ->
    @validator.validate()