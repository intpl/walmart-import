class ScrapeProductJob < ApplicationJob
  # queue_as :default

  def perform(url)
    @url = url
    walmart_id or raise 'invalid url'

    @doc = Nokogiri::HTML(open(@url))

    product = Product.create(
      walmart_id: walmart_id,
      name: name,
      price: price
    )

    AcquireReviewsForProduct.new(walmart_id, product.id).run
  end

  def name
    @doc.at_css(".prod-ProductTitle > div").text
  end

  def price
    price_c = @doc.at_css('.Price-characteristic').text
    price_m = @doc.at_css('.Price-mantissa').text

    "#{price_c}#{price_m}".to_i
  end

  def walmart_id
    @walmart_id ||= @url.match(/\A(https*:\/\/)?(www\.)?walmart.com\/ip\/[\w-]*\/(\d+)/).try(:[], 3)
  end
end
