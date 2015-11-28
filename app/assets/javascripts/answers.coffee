$ ->
  # edit answer
  $('#answers').on 'click', '.edit-answer-link', (e) ->
    e.preventDefault()
    $(this).hide()
    answer_id = $(this).data('answerId')
    $('.content-edit-answer-' + answer_id).hide()
    $('form#form-edit-answer-' + answer_id).show()


  # vote answer
  $('#answers').bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    $("#answer-#{answer.id} .answer_vote").html(JST["templates/votes"]({object: answer}))


  # create answer
  # questionId = gon.questionId
  # channel = '/questions/' + questionId + '/answers'
  # PrivatePub.subscribe channel, (data, channel) ->
  #   answer = $.parseJSON(data['answer'])
    # $('#answers').append(JST["templates/answer"]({answer: answer}))
    # $('#field_answer').val('')
    # $(".nested-fields").hide('')


