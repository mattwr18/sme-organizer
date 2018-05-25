# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(document).on 'turbolinks:load', ->
  ingredients = $('#ingredients')
  $('#add-new-ingredient').click (event) ->
    event.preventDefault()
    $('.ingredient-amount-field').prop 'disabled', false

  ingredients.on 'cocoon:before-insert', (e, el_to_add) ->
    el_to_add.fadeIn("slow")

  ingredients.on 'cocoon:after-insert', (e, added_el) ->
    added_el.effect('highlight', {}, 500)

  ingredients.on 'cocoon:before-remove', (e, el_to_remove) ->
    $(this).data('remove-timeout', 1000)
    el_to_remove.fadeOut(1000)

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
