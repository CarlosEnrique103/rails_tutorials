# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @product = products(:ruby)
    @title = "New edition of Ruby #{rand(1000)}"
  end

  test 'should get index' do
    get products_url
    assert_response :success
  end

  test 'should get new' do
    get new_product_url
    assert_response :success
  end

  test 'should create product' do
    assert_difference('Product.count') do
      post products_url, params: { product: { description: @product.description,
                                              image_url: @product.image_url,
                                              price: @product.price,
                                              title: @title } }
    end
    assert_redirected_to product_url(Product.last)
  end

  test 'should show product' do
    get product_url(@product)
    assert_response :success
  end

  test 'should get edit' do
    get edit_product_url(@product)
    assert_response :success
  end

  test 'should update product' do
    patch product_url(@product), params: { product: { description: @product.description,
                                                      image_url: @product.image_url,
                                                      price: @product.price,
                                                      title: @title } }
    assert_redirected_to product_url(@product)
  end

  test 'should destroy product' do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
  test 'should get list of products' do
    get products_url
    assert_response :success
    assert_select 'h1', 'Products'
    assert_select 'tbody .list_line_odd', minimum: 1
    assert_select 'tbody .list_line_even', minimum: 1
    assert_select 'tbody td a', 'Show', minimum: 1
    assert_select 'tbody td a', 'Edit', minimum: 1
    assert_select 'tbody td a', 'Destroy', minimum: 1
    assert_select 'a', 'New Product', 1
  end
end
