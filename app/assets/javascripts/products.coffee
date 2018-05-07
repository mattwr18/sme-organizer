# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(document).on 'turbolinks:load', ->
  ingredients = $('#ingredients')

  ingredients.on 'cocoon:before-insert', (e, el_to_add) ->
    el_to_add.fadeIn("slow")

  ingredients.on 'cocoon:after-insert', (e, added_el) ->
    ingredientsNestedFields = $('#product_form').find('.nested-fields')
    ingredientsNestedFieldsSize = $(ingredientsNestedFields).length

    added_el.effect('highlight', {}, 500)
    console.log ingredientsNestedFields

    if ingredientsNestedFieldsSize > 1
      a = 1

      while a < ingredientsNestedFieldsSize > 1
        $(ingredientsNestedFields[a]).find('.ingredient_field_name').html '<strong>Ingredient name('+(a + 1)+'):</strong>'
        $(ingredientsNestedFields[a]).find('.ingredient_field_amount').html '<strong>Amount('+(a + 1)+'):</strong>'
        $(ingredientsNestedFields[a]).find('.ingredient_field_amount_type').html '<strong>Amount type('+(a + 1)+'):</strong>'
        a++

  ingredients.on 'cocoon:before-remove', (e, el_to_remove) ->
    $(this).data('remove-timeout', 1000)
    el_to_remove.fadeOut(1000)
