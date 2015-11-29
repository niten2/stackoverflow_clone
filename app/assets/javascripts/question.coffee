$ ->
  # question vote
  $('#question_votes').bind 'ajax:success', (e, data, status, xhr) ->
    question = $.parseJSON(xhr.responseText)
    $('#question_votes').html(JST["templates/votes"]({object: question}))

  # create question private_pub
  channel = '/questions'
  PrivatePub.subscribe channel, (data, channel) ->
    question = $.parseJSON(data['question'])
    user = $.parseJSON(data['user'])
    current_user = $.parseJSON(data['current_user'])
    $('#questions').append(JST["templates/question"]({question: question, current_user: current_user, user: user}))

  # add comment
  $('#question_comment').on 'click', '#add_comment_question', (e) ->
    e.preventDefault()
    form = $("#question_comment_form")
    form.css('display','block')

  $('#question_comment').on 'click', '#remove_comment_question', (e) ->
    e.preventDefault()
    form = $("#question_comment_form")
    form.css('display','none')

    # if !$(this).hasClass('cancel')
    #   $(this).html 'Назад'
    #   $(this).addClass 'cancel'
    # else
    #   $(this).html 'Редактирование'
    #   $(this).removeClass 'cancel'
    # form.toggle()

    # if $(this).css('display') != "none"
    #   $(this).html 'Редактирование'
    #   $(this).removeClass 'cancel'


