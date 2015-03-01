class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  has_many :favorites, dependent: :destroy
    
  

  default_scope { order('rank DESC')}
    scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  
  
 mount_uploader :image, ImageUploader

  #implied self.votes
  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  #?? You can pass a symbol of an attribute to sum, to tell it what to sum in the collection.
  def points
    votes.sum(:value).to_i
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24)
      new_rank = points + age_in_days

      update_attribute(:rank, new_rank)
  end
 
  def markdown_title
    render_as_markdown(self.title)
  end

  def markdown_body
    render_as_markdown(self.body)
  end

  
  def render_as_markdown(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true, highlight: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end

  def create_vote
    user.votes.create(value: 1, post: self)
  end

  def save_with_initial_vote
    if @post.create.votes@post.save_with_initial_voteelse
      redirect_to :post
    end
  end
  
end
  


