module PostValidator
  class Create
    def self.validate(current_object, attrs)
      current_object = self.title(current_object, attrs)
      current_object = self.content(current_object, attrs)
      return current_object
    end

    private
      def self.title(current_object, attrs)
        if attrs[:title] == ''
          current_object.errors.add(:title, 'must be presence')
        end

        if not attrs[:title].length.between?(5, 15)
          current_object.errors.add(:title, 'character length must be between 5..15')
        end

        return current_object
      end

      def self.content(current_object, attrs)
        if attrs[:title] == ''
          current_object.errors.add(:content, 'must be presence')
        end

        if not attrs[:content].length.between?(5, 254)
          current_object.errors.add(:content, 'character length must be between 5..254')
        end

        return current_object
      end
  end
end
