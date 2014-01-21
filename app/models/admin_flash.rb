class AdminFlash < ActiveRecord::Base
  attr_accessible :message, :expires
  
  validates :message, presence: true        
  validates :expires, presence: true  
 
#  If we were to use validates_timeliness gem :   
#  validates_datetime :start_date,
#    :after => :now,
#    :after_message => "Event cannot start in the past"

  def self.unexpired_messages
    self.order("created_at desc").where("expires >= ?", Time.now)
  end

  def self.showable_messages disabled_flash_ids
    unexpired_messages.select{ |msg| !disabled_flash_ids.include?(msg.id) }
  end
end