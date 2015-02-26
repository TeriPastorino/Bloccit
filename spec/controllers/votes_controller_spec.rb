
require 'rails_helper'

describe VotesController do 

  include Devise::TestHelpers

  include TestFactories

  describe '#up_vote' do
    it "adds an up_vote to the post" do

      request.env["HTTP_REFERER"] =  '/'

      @user = authenticated_user
      @post = associated_post
      sign_in @user

      expect {
        post( :up_vote, post_id: @post.id)
      }.to change{ @post.up_votes }.by 1
    end
  end



  describe '#down_vote' do
    it "adds a down_vote to the post" do
      request.env["HTTP_REFERER"] =  '/'
      @user = authenticated_user
      @post = associated_post
      sign_in @user

      expect {
        post( :down_vote, post_id: @post.id)
      }.to change{ @post.down_votes }.by -1
    end
  end

end