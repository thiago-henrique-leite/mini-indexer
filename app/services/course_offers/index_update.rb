module CourseOffers
  class IndexUpdate
    INDEX_NAME = 'course_offers'.freeze

    def initialize(client, course_id)
      @client = client
      @course_id = course_id
    end

    def perform
      build_documents_disabled
      build_documents_enabled
      add_offers_enabled
      delete_offers_disabled
    end

    private

    attr_reader :client, :course_id, :documents_offers_enabled, :documents_offers_disabled

    def offers_enabled
      Offer.enabled.includes(:university_offer,
        :course).joins(:university_offer).where(university_offers: { course_id: course_id })
    end

    def offers_disabled
      Offer.where(enabled: false).includes(:university_offer,
        :course).joins(:university_offer).where(university_offers: { course_id: course_id })
    end

    def build_documents_enabled
      @documents_offers_enabled = offers_enabled.map do |offer|
        CourseOffers::DocumentBuilder.new(offer).build
      end
    end

    def build_documents_disabled
      @documents_offers_disabled = offers_disabled.map do |offer|
        CourseOffers::DocumentBuilder.new(offer).build
      end
    end

    # def index_documents
    def add_offers_enabled
      client.instance.index_documents(INDEX_NAME, documents_offers_enabled)
    end

    def delete_offers_disabled
      client.instance.delete_index(INDEX_NAME, documents_offers_disabled)
    end
  end
end
