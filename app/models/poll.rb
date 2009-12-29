class Poll < ActiveRecord::Base
  has_many :choices
  
  validates_presence_of :url
  validates_uniqueness_of :url
  validate :url_must_be_from_hn
  validate :page_must_be_valid_poll
  
  protected
    def url_must_be_from_hn
      if !url.include? "news.ycombinator.com"
        errors.add(:url, 'error: url must be from Hacker News')
      end
    end
    
    def page_must_be_valid_poll
      begin
        agent = WWW::Mechanize.new
        agent.get(url)
        page = agent.page
        choices = page.search("div font")
        if choices.nil? or choices.size == 0
          errors.add(:url, 'error: not a valid Hacker News poll')
        end
      rescue
        errors.add(:url, 'error: page does not exist')
      end
    end
end
