class CommentsController < ApplicationController
  #before_filter :authenticate_user!
  before_filter :require_signin!
  before_filter :find_ticket
  
  def create
    sanitize_parameters!
    @comment = @ticket.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save!
    	flash[:notice] = "Comment has been created."
    	redirect_to [@ticket.project, @ticket]# <co id="ch10_v2_5_1"/>
    else
      @states = State.all
    	flash[:alert] = "Comment has not been created."
    	render :template => "tickets/show"# <co id="ch10_v2_5_2"/>
    end
  end
  
  private
    def find_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    def comment_params
      params.require(:comment).permit(:text, :state_id, :tag_names)
    end

    def sanitize_parameters!
      if cannot?(:tag, @ticket.project)
        params[:comment].delete(:tag_names)
      end
    end
end
