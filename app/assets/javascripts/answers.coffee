$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    answer_id = $(this).data('answerId')
    $('.content-edit-answer-' + answer_id).hide()
    $('form#form-edit-answer-' + answer_id).show()

