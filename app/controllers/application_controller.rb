# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery

  def get_poll
    agent = WWW::Mechanize.new
    agent.get(@poll.url)
    page = agent.page
    title = page.at(".title a").text
    score = page.at(".subtext span").text.to_i
    choices = page.search("div font").map(&:text).map(&:strip)
    results = page.search(".default:nth-child(2)").map(&:text).map { |p| p.gsub('points','').strip.to_i }
    @poll.title = title
    @poll.score = score
    @poll.choices.delete_all
    choices.size.times do |i|
      Choice.create(:name => choices[i], :votes => results[i], :poll_id => @poll.id)
    end
    @poll.save!
  end
end
