$ ->
  $(document).on 'page:change', ->
    $(".date, input[name$='_on]']").dynDateTime
      firstDay: 1
      ifFormat: "%Y-%m-%d"
    $(".datetime, input[name$='_at]']").dynDateTime
      showsTime: true
      showOthers: true
      firstDay: 1
      ifFormat: "%Y-%m-%d %H:%M:%S"
