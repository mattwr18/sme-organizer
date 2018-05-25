# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).on 'turbolinks:load', ->
  $('.select2-field').select2
    theme: 'bootstrap'
    minimumInputLength: 1
    maximumInputLength: 20
    ajax:
      url: $('.select2-field').data('endpoint')
      dataType: 'json'
      delay: 250
      data: (params) ->
        {
          q: params.term
          page: params.page
        }

      processResults: (data) ->
        {
          results: $.map(data, (item) ->
            {
              text: item.name
              id: item.id
            }
        )}
