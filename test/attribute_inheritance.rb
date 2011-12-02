require 'minitest/autorun'
$:.unshift(File.expand_path('../../lib', __FILE__))
require "attribute_inheritance"

class Person
  extend AttributeInheritance::ModelAdditions
  attr_accessor :last_name, :habits, :parent
  attr_inherited :parent, :last_name, :habits
end

class AttributeInheritanceTest < MiniTest::Unit::TestCase
  def test_accessors_are_not_affected
    person = Person.new
    assert_nil person.last_name
    person.last_name = "Pupkine"
    assert_equal "Pupkine", person.last_name
  end

  def test_only_nil_attributes_are_inherited
    parent = Person.new
    parent.last_name = "Pupkine"
    parent.habits = "Bad ones"

    person = Person.new
    person.habits = "Good ones"

    person.parent = parent
    assert_equal "Pupkine", person.last_name
    assert_equal "Good ones", person.habits
  end

  def test_setting_nil_parent
    person = Person.new
    person.last_name = "Pupkine"
    person.parent = nil
    assert_equal "Pupkine", person.last_name
  end
end
