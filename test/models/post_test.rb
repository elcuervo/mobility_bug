require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'gets translated version via association' do
    post = Post.create(title: 'something')

    post.comments.create!(text: 'english')
    post.comments.create!(text_es: 'español')
    post.comments.create!(text_es: 'kaigi')

    assert_equal ['english'], post.comments.pluck(:text)

    I18n.with_locale(:es) do
      assert_equal ['español'], post.comments.pluck(:text)
    end
  end
end
