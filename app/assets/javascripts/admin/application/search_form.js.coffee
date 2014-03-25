$ ->
  $(document).on 'page:change', ->
    $('#search_form').submit ->
      $(this).find("input[name$='[like]']").each ->
        value = $(this).val().strip()
        $(this).val('%' + value + '%') if value != '' && !value.match(/\%/)
      $(this).find(':input').each ->
        $(this).attr('disabled', true) if $(this).val() == ''
      that = this
      setTimeout((-> $(that).find(':input').attr('disabled', false)), 100)
