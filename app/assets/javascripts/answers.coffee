$ ->
  $('#answers').on 'click', '.edit-answer-link', (e) ->
    e.preventDefault()
    $(this).hide()
    answer_id = $(this).data('answerId')
    $('.content-edit-answer-' + answer_id).hide()
    $('form#form-edit-answer-' + answer_id).show()



# $ ->
#   $('#answers').on 'click', '.answer_edit-link', (e) ->
#     e.preventDefault()
#     $(this).hide()
#     answer_id = $(this).data('answerId')
#     $('form#edit-answer_' + answer_id).show()

  # $('form.new_answer').bind 'ajax:success', (e, data, status, xhr) ->
  #   answer = $.parseJSON(xhr.responseText)
  #   $('#answers').append(JST["templates/answer"]({answer: answer}))
  #   $('.form-control#answer_body').val('')
  # .bind 'ajax:error', (e, xhr, status, error) ->
  #   errors = $.parseJSON(xhr.responseText)
  #   $('.answer-errors').html('')
  #   $.each errors, (index, value) ->
  #     $('.answer-errors').append value

  # $('form.answer_edit-form').bind 'ajax:success', (e, data, status, xhr) ->
  #   answer = $.parseJSON(xhr.responseText)
  #   $('.answer_edit-form').hide()
  #   $('#answer_' + answer.id).replaceWith(JST["templates/answer"]({answer: answer}))
  #   $('.answer_edit-link').show()
  # .bind 'ajax:error', (e, xhr, status, error) ->
  #   errors = $.parseJSON(xhr.responseText)
  #   for value in errors
  #     $(this).prev().remove("p.error")
  #     $(this).before '<p class="error">' + value + '</p>'

  $('#answers').bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    $("#answer_#{answer.id} .answer_vote").html(JST["templates/votes"]({object: answer}))

