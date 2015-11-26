$ ->
  $('#answers').on 'click', '.edit-answer-link', (e) ->
    e.preventDefault()
    $(this).hide()
    answer_id = $(this).data('answerId')
    $('.content-edit-answer-' + answer_id).hide()
    $('form#form-edit-answer-' + answer_id).show()

  $('#answers').bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    $("#answer_#{answer.id} .answer_vote").html(JST["templates/votes"]({object: answer}))

