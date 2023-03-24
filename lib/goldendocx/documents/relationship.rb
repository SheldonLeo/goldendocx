# frozen_string_literal: true

module Goldendocx
  module Documents
    class Relationship
      include Goldendocx::Element

      attr_reader :id, :type, :target

      tag :Relationship

      attribute :id, alias_name: :Id
      attribute :type, alias_name: :Type
      attribute :target, alias_name: :Target
    end
  end
end
