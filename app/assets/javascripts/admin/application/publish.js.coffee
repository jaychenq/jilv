$ ->
  $(document).on 'page:change', ->
    $('.publish_button').on 'click', ->
      return false if !$(this).hasClass('enable') || $(this).hasClass('loading')
      $.ajax
        type: 'PUT'
        url: $(this).data().root + '/' + $(this).data().id + '/' + (if $(this).hasClass('active') then 'withdraw' else 'publish')
        context: this
        beforeSend: -> $(this).addClass('loading')
      .always -> $(this).removeClass('loading')
      .done -> $(this).toggleClass('active')
      false
