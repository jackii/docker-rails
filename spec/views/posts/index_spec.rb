require 'rails_helper'

describe 'posts/index' do
  before :each do
    2.times { create(:post, title: 'Foo', content: 'Lorem ipsum') }
    assign :posts, Post.all.page(1)
  end

  it 'renders a list of posts' do
    render

    assert_select 'post-listing', count: 1
  end
end
