# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def new_product(image_url)
    Product.new(title: 'Product 1',
                description: 'Product description',
                price: 1,
                image_url: image_url)
  end

  test 'product attribute must not be a empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test 'product price must be positive' do
    product = Product.new(title: 'New product', description: 'Product on sale', image_url: 'image.png')
    product.price = -1
    assert product.invalid?
    assert ['must be greater than or equal to 0.01'], product.errors[:price]
    product.price = 0
    assert product.invalid?
    assert ['must be greater than or equal to 0.01'], product.errors[:price]
    product.price = 10
    assert product.valid?, "#{product.price} no es válido"
  end

  test 'product title length must be greater than 1' do
    product = Product.new(description: 'Product on sale', image_url: 'image.png', price: 10)
    product.title = ''
    assert product.invalid?
    product.title = 'New product'
    assert product.valid?, "#{product.title} no es válido"
  end

  test 'product title length must be less than 1' do
    product = Product.new(description: 'Product on sale', image_url: 'image.png', price: 10)
    product.title = 'a' * 251
    assert product.invalid?
    product.title = 'New product'
    assert product.valid?, "#{product.title} no es válido"
  end

  test 'image url must be have a format permited' do
    ok = %w[fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif]
    bad = %w[fred.doc fred.more fred.xls]

    ok.each  do |image_url|
      assert new_product(image_url).valid?, "#{image_url} shouldn't be valid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} shouldn't be valid"
    end
  end

  test 'product is not valid without a unique title' do
    product = Product.new(title: products(:ruby).title, description: 'yyy', price: 1, image_url: 'image.png')
    assert product.invalid?
    assert_equal ['has already been taken'], product.errors[:title]
  end

  test 'product is not a valid without a unique title - i18n' do
    product = Product.new(title: products(:ruby).title, description: 'yyy', price: 1, image_url: 'image.png')
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end
end
