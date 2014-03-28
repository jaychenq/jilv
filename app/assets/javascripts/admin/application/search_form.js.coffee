$ ->
  $(document).on 'page:change', ->
    $('#search_form').submit ->
      $(this).find("input[name$='[like]']").each ->
        $(this).val('%' + $(this).val() + '%') if !$(this).val().match(/\%|^\s*$/)
      $(this).find(':input').each ->
        $(this).attr('disabled', true) if $(this).val().match(/^\s*$/)
      that = this
      setTimeout((-> $(that).find(':input').attr('disabled', false)), 500)
