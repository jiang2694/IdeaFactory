class Ability < ApplicationRecord
  include CanCan::Ability

  def initialize(user)

      user ||= User.new 

    if user.is_admin?
        can :manage, :all
    end
   
    alias_action :create, :read, :update, :destroy, to: :crud


    can(:like, Idea) do |idea|
      user.persisted? && idea.user != user
    end

    can(:destroy, Like) do |like|
      like.user == user
    end


    can(:crud, Idea) do |idea|
      idea.user == user
    end

    can(:crud, Review) do |review|
      review.user == user

    end

  end
  
end
