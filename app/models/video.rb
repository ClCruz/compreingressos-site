class Video < ActiveRecord::Base
  validates_presence_of :legenda, :youtube_id
  
  belongs_to :asset, :polymorphic => true
end
