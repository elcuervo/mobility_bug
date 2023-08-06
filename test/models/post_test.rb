# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def comments(post)
    c = post.comments
    unless I18n.default_locale == I18n.locale
      c = c.joins('INNER JOIN mobility_string_translations
                   ON mobility_string_translations.translatable_id = comments.id')
      c = c.where(
        "mobility_string_translations.translatable_type = 'Comment'
        AND mobility_string_translations.key = 'text'
        AND mobility_string_translations.locale = ?", I18n.locale.to_s
      )
    end
    c.pluck(:text)
  end

  test 'gets translated version via association' do
    post = Post.create(title: 'something')

    comment = post.comments.create!(text: 'english')

    comment.update!(text_es: 'español')
    comment.update!(text_ja: 'kaigi')

    assert_equal ['english'], comments(post)

    I18n.with_locale(:es) do
      assert_equal ['español'], comments(post)
    end

    I18n.with_locale(:ja) do
      assert_equal ['kaigi'], comments(post)
    end
  end
end
