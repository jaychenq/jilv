#= require jquery.min
#= require jquery_ujs
#= require jqueryui
#= require turbolinks
#= require underscore
# require admin/application/datetime
# require admin/application/editor
#= require jquery.validationEngine
#= require languages/jquery.validationEngine-zh_CN
#= require jquery.datetimepicker
#= require shared/analytics

$ ->
  $(document).on 'page:change', ->
    $('._add_travel_favorite').on 'click', ->
      $.ajax({
        type: 'post'
        url: '/travel/favorites'
        data: { 'travel_favorite[product_id]': $(this).data('product-id') }
      })
      .done(->alert('收藏成功'))
      false
    $('._remove_travel_favorite').on 'click', ->
      $.ajax({
        type: 'delete'
        url: '/travel/favorites/' + $(this).data('id')
      })
      .done(->alert('成功取消'))
      document.location.reload()
      false
