require 'tempfile'
require 'activerecord'

Tempfile.class_eval do
  # overwrite so tempfiles use the extension of the basename.  important for rmagick and image science
  def make_tmpname(basename, n)
    ext = nil
    sprintf("%s%d-%d%s", basename.to_s.gsub(/\.\w+$/) { |s| ext = s; '' }, $$, n, ext)
  end
end

require 'geometry'

require 'technoweenie/attachment_fu'

ActiveSupport::Dependencies.load_paths << File.dirname(__FILE__)

ActiveRecord::Base.send(:extend, Technoweenie::AttachmentFu::ActMethods)
Technoweenie::AttachmentFu.tempfile_path = ATTACHMENT_FU_TEMPFILE_PATH if Object.const_defined?(:ATTACHMENT_FU_TEMPFILE_PATH)
FileUtils.mkdir_p Technoweenie::AttachmentFu.tempfile_path
