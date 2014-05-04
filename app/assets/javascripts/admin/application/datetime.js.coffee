#= require dyndatetime/dynDateTime
#= require dyndatetime/calendar-zh

$ ->
  $(document).on 'page:change', ->
    $("input.date, input[name$='_on]']").dynDateTime
      firstDay: 1
      ifFormat: "%Y-%m-%d"
    $("input.datetime, input[name$='_at]']").dynDateTime
      showsTime: true
      showOthers: true
      firstDay: 1
      ifFormat: "%Y-%m-%d %H:%M:%S"
