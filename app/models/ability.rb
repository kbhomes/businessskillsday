class Ability
  include CanCan::Ability

  def initialize(account)
    alias_action :delete, :to => :destroy

    case account
      when ChapterAccount   then chapter_account_abilities(account)
      when StaffAccount     then staff_account_abilities(account)
      when AdminAccount     then admin_account_abilities(account)
      else                       no_account_abilities
    end
  end

  private

    def no_account_abilities
      cannot :manage, :all
      can :create, Registration
    end

    def chapter_account_abilities(account)
      chapter = account.chapter

      can [:read, :update, :results], Chapter, :id => chapter.id

      can :manage, Adviser, :chapter_id => chapter.id
      can :manage, Student, :chapter_id => chapter.id
      can :manage, Team, :chapter_id => chapter.id
      can [:read, :update], Account, :id => account.id
    end

    def staff_account_abilities(account)
      can [:read, :results], Chapter
      can :read, Adviser
      can :read, Student
      can :read, Team
      can :read, Event
      can :manage, Result
      can [:read, :update], Account, :id => account.id

      can :manage, :admin
    end

    def admin_account_abilities(account)
      can :manage, :all

      # Explicit permissions for reference.
      can :update, :passwords
    end
end
