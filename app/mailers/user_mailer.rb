class UserMailer < ApplicationMailer

  def daily_digest(user, questions)
    @user = user
    @questions = Question.created_yesterday
    mail(to: user.email, subject: "Ежедневный список вопросов созданных за сегодня")
  end

  def subscription_question(user)

    # @answer = answer
    # @question = @answer.question
    # @followers = @question.followers

    mail(to: user.email, subject: "На вопрос, который вы подписались ответили")
  end

end
