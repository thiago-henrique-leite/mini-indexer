module ElasticSearch
    class Client
        def initialize
            @client = Elasticsearch::Client.new(host: host)
        end

        def index(documents)
            client.bulk(body: documents)
        end

        private

        attr_reader :client

        def host
            Settings.elastic_search.host
        end
    end
end