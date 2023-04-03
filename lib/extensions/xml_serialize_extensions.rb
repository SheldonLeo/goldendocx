# frozen_string_literal: true

class String
  def self.read_from(node, multiple: false)
    values = node.extract_contents

    multiple ? Array(values) : values.first
  end
end

class Time
  def self.read_from(node, multiple: false)
    values = node.extract_contents.map(&:to_time)

    multiple ? Array(values) : values.first
  end

  def to_element(**_context)
    strftime('%Y-%m-%dT%H:%M:%SZ')
  end
end

class Integer
  def self.read_from(node, multiple: false)
    values = node.extract_contents.map(&:to_i)

    multiple ? Array(values) : values.first
  end

  def to_element(**_context)
    to_s
  end
end
