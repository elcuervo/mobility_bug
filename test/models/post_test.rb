require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def comments(post)
    c = post.comments
    c = c.eager_load(:string_translations) unless I18n.default_locale == I18n.locale

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
