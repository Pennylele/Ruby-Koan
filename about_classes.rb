require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutClasses < Neo::Koan
  class Dog
  end

  def test_instances_of_classes_can_be_created_with_new
    fido = Dog.new
    assert_equal Dog, fido.class
  end

  # ------------------------------------------------------------------

  class Dog2
    def set_name(a_name)
      @name = a_name
    end
  end

  def test_instance_variables_can_be_set_by_assigning_to_them
    fido = Dog2.new
    assert_equal [ ], fido.instance_variables #In this case, fido doesn't have any instance_variables, since Fido is an instance of Dog2. It has a set_name method, but doesn't have an instance variable. 
    fido.set_name("Fido")
    assert_equal [:@name], fido.instance_variables #In this case, fido has an instance_variable, because it uses the set_name methods initialized in set_name method.
  end

  def test_instance_variables_cannot_be_accessed_outside_the_class
    fido = Dog2.new
    fido.set_name("Fido")

    assert_raise(NoMethodError) do
      fido.name
    end

    assert_raise(SyntaxError) do
      eval "fido.@name"
      # NOTE: Using eval because the above line is a syntax error.
    end
  end

  def test_you_can_politely_ask_for_instance_variable_values
    fido = Dog2.new
    fido.set_name("Fido")

    assert_equal "Fido", fido.instance_variable_get("@name")
  end

  def test_you_can_rip_the_value_out_using_instance_eval
    fido = Dog2.new
    fido.set_name("Fido")

    assert_equal "Fido", fido.instance_eval("@name")  # string version By using instance_eval, we can run code as if we were inside a method of the specific object we call it on. 
    assert_equal "Fido", fido.instance_eval { @name } # block version still a bit vague
    #http://web.stanford.edu/~ouster/cgi-bin/cs142-winter15/classEval.php
  end

  # ------------------------------------------------------------------

  class Dog3
    def set_name(a_name)
      @name = a_name
    end
    def name
      @name
    end
  end

  def test_you_can_create_accessor_methods_to_return_instance_variables
    fido = Dog3.new
    fido.set_name("Fido")

    assert_equal "Fido", fido.name
  end

  # ------------------------------------------------------------------

  class Dog4
    attr_reader :name # this is equal to - def name @name end

    def set_name(a_name)
      @name = a_name
    end
  end


  def test_attr_reader_will_automatically_define_an_accessor
    fido = Dog4.new
    fido.set_name("Fido")

    assert_equal "Fido", fido.name
  end

  # ------------------------------------------------------------------

  class Dog5
    attr_accessor :name
  end


  def test_attr_accessor_will_automatically_define_both_read_and_write_accessors
    fido = Dog5.new

    fido.name = "Fido"
    assert_equal "Fido", fido.name
  end

  # ------------------------------------------------------------------

  class Dog6
    attr_reader :name 
    def initialize(initial_name)
      @name = initial_name 
    end
  end

  def test_initialize_provides_initial_values_for_instance_variables
    fido = Dog6.new("Fido")
    assert_equal "Fido", fido.name
  end

  def test_args_to_new_must_match_initialize
    assert_raise(ArgumentError) do
      Dog6.new
    end
    # THINK ABOUT IT:
    # Why is this so? Because it didn't have any argument?
  end

  def test_different_objects_have_different_instance_variables
    fido = Dog6.new("Fido")
    rover = Dog6.new("Rover")

    assert_equal true, rover.name != fido.name
  end

  # ------------------------------------------------------------------

  class Dog7
    attr_reader :name

    def initialize(initial_name)
      @name = initial_name
    end

    def get_self
      self
    end

    def to_s
      @name
    end

    def inspect
      "<Dog named '#{name}'>"
    end
  end

  def test_inside_a_method_self_refers_to_the_containing_object
    fido = Dog7.new("Fido")

    fidos_self = fido.get_self
    assert_equal fido, fidos_self #self returns the previous method or class
  end

  def test_to_s_provides_a_string_version_of_the_object
    fido = Dog7.new("Fido")
    assert_equal "Fido", fido.to_s
  end

  def test_to_s_is_used_in_string_interpolation
    fido = Dog7.new("Fido")
    assert_equal "My dog is Fido", "My dog is #{fido}"
  end

  def test_inspect_provides_a_more_complete_string_version
    fido = Dog7.new("Fido")
    assert_equal "<Dog named 'Fido'>", fido.inspect
  end

  def test_all_objects_support_to_s_and_inspect
    array = [1,2,3]

    assert_equal "[1, 2, 3]", array.to_s
    assert_equal "[1, 2, 3]", array.inspect #not very sure about what's the difference between to_s and inspect 
    #http://stackoverflow.com/questions/2625667/why-do-this-ruby-object-have-two-to-s-and-inspect-methods-that-seems-do-the-same

    assert_equal "STRING", "STRING".to_s #make it a string, no matter what, even if it's an array.
    assert_equal "\"STRING\"", "STRING".inspect #this is interesting...??
    #https://gist.github.com/kinopyo/5682347
  end
end
