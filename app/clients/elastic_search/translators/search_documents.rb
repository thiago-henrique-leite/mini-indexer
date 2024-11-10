module ElasticSearch
  module Translators
    class SearchDocuments
      def initialize(key, names)
        @key = "#{key}.keyword"
        @names = names
      end

      def translate
        {
          "query": {
              "terms": {
                key => [names]
              }
          },
          _source: ["_id"]
        }
      end
  
      private
  
      attr_reader :key, :names
    end
  end
end