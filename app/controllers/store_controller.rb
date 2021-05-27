# frozen_string_literal: true

class StoreController < ApplicationController
  include CounterStore
  before_action :counter_push, only: :index

  def index
    @products = Product.order(:title)
  end
end
