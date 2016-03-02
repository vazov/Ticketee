class Ticket < ActiveRecord::Base
  belongs_to :state
  belongs_to :project
  belongs_to :user
  has_many :assets
  has_many :comments
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :assets
  has_and_belongs_to_many :watchers, join_table: "ticket_watchers",
                                     class_name: "User"
  validates :title, presence: true
  validates :description, presence: true

  before_create :associate_tags
  after_create :creator_watches_me
  mount_uploader :asset, AssetUploader

  attr_accessor :tag_names
  
  searcher do
    label :tag, :from => :tags, :field => :name
  end

  private

    def associate_tags
      if tag_names
        tag_names.split(" ").each do |name|
          self.tags << Tag.where(name: name).first_or_create
        end
      end
    end

    def creator_watches_me
      if user
        self.watchers << user unless self.watchers.include?(user)
      end
    end
end
