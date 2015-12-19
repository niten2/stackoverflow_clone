class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
    can :manage, SearchQuery
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :manage, [Question, Answer, Comment], user: user
    can :manage, Attachment, attachable: {user: user}

    can :make_best, Answer, question: { user: user }

    can :subscribe, Question do |question|
      !question.followers.include? user
    end

    can :unsubscribe, Question do |question|
      question.followers.include? user
    end

    can :update, [Question, Answer, Comment], user: user
    can :create, Comment

    can :destroy, Answer, question: { user: user }
    can :destroy, Comment, commentable: { user: user }

    alias_action :upvote, :downvote, :unvote, to: :vote
    can :vote, [Question, Answer]
    cannot :vote, [Question, Answer], user: user

    can :me, User, id: user.id

    can :manage, SearchQuery
  end
end
