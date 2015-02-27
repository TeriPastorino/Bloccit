module ApplicationHelper
  def form_group_tag(errors)
    if errors.any?
       'form-group has-error'
    else
     'form-group'
    end
  end

    # def up_vote_link_classes(post)
    #         "glyphicon glyphicon-chevron-up #{(current_user.voted(post) && current_user.voted(post).up_vote?) ? 'voted':  ""}"
            
    # end

    def up_vote_link_classes(post)
      teri_is_cool = "glyphicon glyphicon-chevron-up"
      if current_user.voted(post) && current_user.voted(post).up_vote?
        teri_is_cool += " voted"
      end           
      teri_is_cool            
    end

    def down_vote_link_classes(post)
            "glyphicon glyphicon-chevron-down #{(current_user.voted(post) && current_user.voted(post).down_vote?) ? 'voted':  ""}"
    end


end
