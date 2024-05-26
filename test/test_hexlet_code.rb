# frozen_string_literal: true

require "test_helper"

# HexletCode tests
class TestHexletCode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_that_form_for_makes_form
    assert_equal ::HexletCode.form_for(1) { |f| }, "<form action='#' method='post'></form>"
  end

  def test_that_form_for_accepts_url
    assert_equal ::HexletCode.form_for(1, { url: "/form" }) { |f| }, "<form action='/form' method='post'></form>"

  end
end
