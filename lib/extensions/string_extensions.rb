# frozen_string_literal: true

class String
  def self.read_from(node)
    [node.text.to_s]
  end
end
