class PostPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, post)
      @user = user
      @post = post
    end

    def resolve
      if user.admin? || user.moderator?
          scope.all
      elsif user
        scope.where(:user_id => user.id) 
      else  
        []  
      end
    end
  end

  def destroy?
    user.present? && (record.user == user || user.admin? || user.moderator?)
  end


  def index?
    true
  end
end
