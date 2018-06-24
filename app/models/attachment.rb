class Attachment < ActiveRecord::Base
  
  mount_uploader :data, AttachmentUploader, :mount_on => :data_file_name
  
  def attachable
    klass = Object.const_get self.attachable_type
    @attachable ||= klass.where('uniq_id = :id or id = :id', { id: self.attachable_id }).first
  end
  
  def ownerable
    klass = Object.const_get self.ownerable_type
    @ownerable ||= klass.where('uniq_id = :id or id = :id or uid = :id', { id: self.ownerable_id }).first
  end
  
end
