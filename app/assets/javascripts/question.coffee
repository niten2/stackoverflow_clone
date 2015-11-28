$ ->
  $('#question_votes').bind 'ajax:success', (e, data, status, xhr) ->
    question = $.parseJSON(xhr.responseText)
    $('#question_votes').html(JST["templates/votes"]({object: question}))

  # create question
  channel = '/questions'
  PrivatePub.subscribe channel, (data, channel) ->
    question = $.parseJSON(data['question'])
    user = $.parseJSON(data['user'])
    current_user = $.parseJSON(data['current_user'])

    console.log user


    $('#questions').append(JST["templates/question"]({question: question, current_user: current_user, user: user}))



#     answer = $.parseJSON(data['answer'])
#     $('#answers').append(JST["templates/answer"]({answer: answer}))
#     $('#field_answer').val('')
#     $(".nested-fields").hide('')

