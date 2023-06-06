require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'gets translated version via association' do
    post = Post.create(title: 'something')

    post.comments.create!(text: 'english')

    I18n.with_locale(:es) do
      post.comments.create!(text: 'español')
    end

    assert_equal post.comments.pluck(:text), ['english']
  end
end
