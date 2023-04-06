# frozen_string_literal: true

class String
  class << self
    def adapt?(xml_node)
      xml_node.is_a?(String) || xml_node.adapt?(String)
    end

    def read_from(xml_node)
      xml_node.to_s
    end
  end
end

class Time
  class << self
    def adapt?(xml_node)
      xml_node.is_a?(String) || xml_node.adapt?(Time)
    end

    def read_from(xml_node)
      xml_node.to_s.to_time
    end
  end

  def to_element(**_context)
    strftime('%Y-%m-%dT%H:%M:%SZ')
  end
end

class Integer
  class << self
    def adapt?(xml_node)
      xml_node.is_a?(String) || xml_node.adapt?(Integer)
    end

    def read_from(xml_node)
      xml_node.to_s.to_i
    end
  end

  def to_element(**_context)
    to_s
  end
end
