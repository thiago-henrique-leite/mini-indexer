module ElasticSearch
  module Translators
    class Documents
      def initialize(index, documents)
        @index = index
        @documents = documents
      end

      def translate
        documents.flat_map do |document|
          [
            {
              index: {
                _index: index,
                _id: document[:offer_id]
              }
            }
          ].append(document)
        end
      end

      private

      attr_reader :index, :documents
    end
  end
end
