require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'gets translated version via association' do
    post = Post.create(title: 'something')

    comment = post.comments.create!(text: 'english')

    comment.update!(text_es: 'español')
    comment.update!(text_ja: 'kaigi')

    assert_equal ['english'], post.comments.pluck(:text)

    I18n.with_locale(:es) do
      assert_equal ['español'], post.comments.pluck(:text)
    end
  end
end
