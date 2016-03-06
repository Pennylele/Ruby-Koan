require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutNil < Neo::Koan
  def test_nil_is_an_object
    assert_equal true, nil.is_a?(Object), "Unlike NULL in other languages"
  end

  def test_you_dont_get_null_pointer_errors_when_calling_methods_on_nil
    # What happens when you call a method that doesn't exist.  The
    # following begin/rescue/end code block captures the exception and
    # makes some assertions about it.
    begin
      nil.some_method_nil_doesnt_know_about
    rescue Exception => ex #Any potential error is captured by the rescue keyword. The rescue Exception => ex line receives that and assigns it to a local variable ex.
      # What exception has been caught?
      assert_equal NoMethodError, ex.class #ex has a class because it is an exception object. Every object in Ruby has a class.
      # What message was attached to the exception?
      # (HINT: replace __ with part of the error message.)
      assert_match(/undefined method/, ex.message)
      #The difference between assert_equal and assert_match is Whether they apply equality == or regex match =~ to check the test.
      #The reason that `/ /` is used is because To make it a regex, as a substring would not match a string containing it.
    end
  end

  def test_nil_has_a_few_methods_defined_on_it
    assert_equal true, nil.nil?
    assert_equal "", nil.to_s #The "inspect" method of the Object class is supposed to return a human-readable version of the object.
    assert_equal "nil", nil.inspect

    # THINK ABOUT IT:
    #
    # Is it better to use
    #    obj.nil?
    # or
    #    obj == nil
    # Why?
  end

end
