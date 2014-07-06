require 'open3'

class RegexTree
  PRINT_REGEX_FILENAME = File.expand_path "../../vendor/onig-5.9.5/print_regex", __FILE__

  def initialize(uncompiled_regex)
    @uncompiled_regex = uncompiled_regex
  end

  def call
    get_raw_tree
  end

  private

  def get_raw_tree
    out, err, status = Open3.capture3(PRINT_REGEX_FILENAME, @uncompiled_regex)
    err.split(/=====  (?:BEGIN|END) JOSH SECTION =====/)[1].strip
  end
end
