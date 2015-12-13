class UserMailer < ApplicationMailer

  def daily_digest(user, questions)
    @user = user
    @questions = Question.created_yesterday
    mail(to: user.email, subject: "Ежедневный список вопросов созданных за сегодня")
  end

  def owner_question(user, question, answer)
    @user = user
    @question = question
    @answer = answer
    mail(to: user.email, subject: "Появился новый ответ в вашем вопросе")
  end

  def subscription_question(user, question, answer)
    @user = user
    @question = question
    @answer = answer
    mail(to: user.email, subject: "На вопрос, который вы подписались ответили")
  end

end
