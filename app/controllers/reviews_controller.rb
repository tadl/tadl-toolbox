class ReviewsController < ApplicationController
  before_filter :set_headers
  respond_to :html, :json, :js
      
  def goodreads
    if params[:isbn] && params[:isbn] != ''
      response = cache.get('goodreads_' + params[:isbn]) rescue nil
      if !response
        all_isbns = String.new
        params[:isbn].split(',').each do |i|
          isbn = StdNum::ISBN.normalize(i) rescue nil
          if isbn
            all_isbns += isbn + ','
          end
        end
      end
      request_url = 'https://www.goodreads.com/book/review_counts.json?isbns=' + all_isbns
      reviews = JSON.parse(open(request_url).read) rescue nil
      if reviews
        response = process_reviews(reviews)
        Rails.cache.write('goodreads_' + params[:isbn], response, :expires_in => 24.hours)
      else
        response = {:message => "No reviews for this item found"}
      end
    else
      response = {:message => "error: no isbn provided"}
    end
    respond_to do |format|
      format.json {render :json => response.to_json}
    end
  end

  private

  def process_reviews(reviews)
    raw = reviews["books"][0]["average_rating"]
    rounded = (raw.to_f * 2).round / 2.0
    stars = rating_to_stars(rounded)
    gr_id = reviews["books"][0]["id"]
    gr_link = 'https://www.goodreads.com/book/show/' + gr_id.to_s
    return {:gr_id => gr_id, :raw => raw, :rounded => rounded, :stars_html => stars, :gr_link => gr_link} 
  end

  def rating_to_stars(rounded)
    stars = '&#9733;' * rounded.to_i
    remainder = rounded.to_i - rounded
    if remainder != 0
      stars = stars + '&frac12;'
    end
    return stars
  end
end