require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test "should not save article without title" do
    book = Book.new
    assert_not book.save , "Saved the article without a title"
  end
  
  def test_the_truth
    assert true
  end
  
  test "should report error" do
    # some_undefined_variable is not defined elsewhere in the test case
    assert_raises(NameError) do
      some_undefined_variable
    end
  end 
  
end
