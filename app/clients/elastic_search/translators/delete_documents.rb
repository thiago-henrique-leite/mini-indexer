module ElasticSearch
  module Translators
    class DeleteDocuments
      def initialize(index, documents)
        @index = index
        @documents = documents
      end

      def translate
        documents.flat_map do |document|
          [
            {
              delete: {
                _index: index,
                _id: document[:object_id]
              }
            }
          ]
        end
      end

      private

      attr_reader :index, :documents
    end
  end
end