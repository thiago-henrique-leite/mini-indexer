class CourseOfferIndexer
  COURSE_OFFER_INDEX = 'course_offers'.freeze

  def initialize(client)
    @client = client
  end

  def perform
    build_documents
    index_documents
  end

  private

  attr_reader :index, :client, :documents

  def offers
    Offer.enabled.includes(:university_offer, :course)
  end

  def build_documents
    @documents = offers.map do |offer|
      client.instance.offer_translator(offer).translate
    end
  end

  def index_documents
    index_manager = IndexManager.new(COURSE_OFFER_INDEX, client)
    index_manager.index_documents(documents)
  end
end
