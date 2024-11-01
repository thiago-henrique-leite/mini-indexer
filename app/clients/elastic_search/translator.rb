module ElasticSearch
  class Translator
    def translate(documents, index_name)
      documents.flat_map do |document|
        [
          { index: {_index: index_name, _id: document[:id] } }
        ].append(document)
      end
    end
  end
end
