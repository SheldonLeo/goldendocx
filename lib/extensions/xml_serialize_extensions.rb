# frozen_string_literal: true

class String
  def self.read_from(node, multiple: false)
    value = node.nodes.pop

    multiple ? [value.to_s] : value.to_s
  end
end

class Time
  def self.read_from(node, multiple: false)
    value = node.nodes.pop

    multiple ? [value.to_time] : value.to_time
  end

  def to_element
    strftime('%Y-%m-%dT%H:%M:%SZ')
  end
end

class Integer
  def self.read_from(node, multiple: false)
    value = node.nodes.pop

    multiple ? [value.to_i] : value.to_i
  end

  alias to_element to_s
end
