class IndexManager
  def initialize(index, client)
    @index = index
    @client = client
  end

  def index_documents(documents)
    client.instance.index_documents(index, documents)
  end

  private

  attr_reader :index, :client
end
