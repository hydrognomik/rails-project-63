# frozen_string_literal: true

require "test_helper"

def load_fixture(path)
  File.open(path, &:readline)
end

User = Struct.new(:name, :job, :gender, keyword_init: true)

# HexletCode tests
class TestHexletCode < Minitest::Test
  attr_reader :user
  def setup
    @user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
  end
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  # Tag.build tests
  def test_that_br_tag_builds
    assert_equal "<br>", HexletCode::Tag.build("br")
  end

  # Form tests
  def test_that_form_for_makes_form
    assert_equal "<form action=\"#\" method=\"post\"></form>", ::HexletCode.form_for(1) { |f| }
  end

  def test_that_form_for_accepts_url
    assert_equal "<form action=\"/form\" method=\"post\"></form>", ::HexletCode.form_for(1, { url: "/form" }) { |f| }
  end

  def test_that_form_for_builds_inputs
    actual_form = HexletCode.form_for user do |f|
      f.input :name
    end
    assert_equal load_fixture(File.expand_path("./fixtures/input.txt", __dir__)), actual_form
  end

  def test_that_form_for_accepts_arbitrary_attributes
    actual_form = HexletCode.form_for user do |f|
      f.input :name, class: "user-input"
    end
    assert_equal load_fixture(File.expand_path("./fixtures/input_class.txt", __dir__)), actual_form
  end

  def test_that_form_for_builds_textarea
    actual_form = HexletCode.form_for user do |f|
      f.input :job, as: :text
    end
    assert_equal load_fixture(File.expand_path("./fixtures/textarea.txt", __dir__)), actual_form
  end

  def test_that_form_for_builds_textarea_with_rows_cols
    actual_form = HexletCode.form_for user do |f|
      f.input :job, as: :text, cols: 30, rows: 50
    end
    assert_equal load_fixture(File.expand_path("./fixtures/rows_cols.txt", __dir__)), actual_form
  end

  def test_that_form_for_raises_if_fields_is_absent
    missing_key = :foobar
    error = assert_raises NoMethodError do
      HexletCode.form_for user do |f|
        f.input missing_key
      end
    end
    assert_match /undefined method `#{missing_key}'/, error.message
  end
end
