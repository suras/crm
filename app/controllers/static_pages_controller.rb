class StaticPagesController < ApplicationController
  def faq
  	render layout: false
  end

  def billing_info
  render layout: false
  end
end
