class PollsController < ApplicationController
  def index
    @polls = Poll.find(:all, :order => 'score DESC').paginate :page => params[:page], :per_page => 10
  end

  def show
    @poll = Poll.find(params[:id])
    @poll.choices.sort! { |a,b| b.votes <=> a.votes } if params[:sort]
    @categories = @poll.choices.map(&:name)
    @results = @poll.choices.map(&:votes)
  end

  def new
    @poll = Poll.new
  end

  def edit
    @poll = Poll.find(params[:id])
  end

  def create
    @poll = Poll.new(params[:poll])

    respond_to do |format|
      if @poll.save
        get_poll
        flash[:notice] = 'Poll was successfully created.'
        format.html { redirect_to(@poll) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @poll = Poll.find(params[:id])
    respond_to do |format|
      if @poll.updated_at < 10.minutes.ago
        @poll.score = 0 #change to make update effective
        @poll.update_attributes(params[:poll])
        get_poll
        flash[:notice] = 'Poll was successfully updated'
      else
        flash[:notice] = 'Please wait 10 minutes between updates'
      end
      format.html { redirect_to(@poll) }
    end
  end


  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy

    respond_to do |format|
      format.html { redirect_to(polls_url) }
      format.xml  { head :ok }
    end
  end
  
end
