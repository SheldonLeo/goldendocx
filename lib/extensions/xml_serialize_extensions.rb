# frozen_string_literal: true

class String
  def self.read_from(node, multiple: false)
    multiple ? [node.text.to_s] : node.text.to_s
  end
end

class Time
  def self.read_from(node, multiple: false)
    multiple ? [node.text.to_time] : node.text.to_time
  end

  def to_element
    strftime('%Y-%m-%dT%H:%M:%SZ')
  end
end

class Integer
  def self.read_from(node, multiple: false)
    multiple ? [node.text.to_i] : node.text.to_i
  end

  alias to_element to_s
end
