#= require jquery.lazyload

$ ->
  $(document).on 'page:change', ->
    $(".lazyload").lazyload()
