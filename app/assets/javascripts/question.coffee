$ ->
  $('#question_votes').bind 'ajax:success', (e, data, status, xhr) ->
    question = $.parseJSON(xhr.responseText)
    console.log question
    # alert "question_wrapper"
    $('.question_votes').html(JST["templates/votes_bar"]({object: question}))
