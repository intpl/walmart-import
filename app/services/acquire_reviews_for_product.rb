class AcquireReviewsForProduct
  def initialize(walmart_id, product_id)
    @walmart_id = walmart_id
    @product_id = product_id

    url = "http://api.walmartlabs.com/v1/reviews/#{@walmart_id}?apiKey=#{ENV['WALMART_API_KEY']}"
    response = Net::HTTP.get(URI(url))
    @parsed_json = JSON.parse(response)
  end

  def run
    reviews = @parsed_json["reviews"]
    reviews.each do |review|
      Review.create(
        product_id: @product_id,
        author: review['reviewer'],
        content: review['reviewText'],
        rating: review['overallRating']['rating']
      )
    end
  end
end
