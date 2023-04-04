# frozen_string_literal: true

module Goldendocx
  module Documents
    module Properties
      class PageMarginProperty
        include Goldendocx::Element

        namespace :w
        tag :pgMar

        attribute :top, namespace: :w, default: 1440
        attribute :bottom, namespace: :w, default: 1440
        attribute :left, namespace: :w, default: 1800
        attribute :right, namespace: :w, default: 1800
        attribute :header, namespace: :w, default: 851
        attribute :footer, namespace: :w, default: 992
        attribute :gutter, namespace: :w, default: 0

        # Follow html margin style setting
        def margin=(*args)
          args = Array(*args)
          raise StandardError("wrong number of arguments (given #{args.length}, expected 1..4)") unless (1..4).cover?(args.length)

          margins =
            case args.length
            when 1 then [args.first] * 4
            when 2 then [args.first, args.last, args.first, args.last]
            when 3 then [args.first, args.second, args.last, args.second]
            else args
            end
          assign_attributes(**%i[top right bottom left].zip(margins).to_h)
        end
      end
    end
  end
end
