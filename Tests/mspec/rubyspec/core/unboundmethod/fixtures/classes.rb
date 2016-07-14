module UnboundMethodSpecs
  module Mod
    def from_mod; end
  end

  class Methods
    include Mod

    def foo
      true
    end
    alias bar foo
    alias alias_1 foo
    alias alias_2 foo

    def original_body(); :this; end
    def identical_body(); :this; end

    def one; end
    def two(a); end
    def three(a, b); end
    def four(a, b, &c); end

    def neg_one(*a); end
    def neg_two(a, *b); end
    def neg_three(a, b, *c); end
    def neg_four(a, b, *c, &d); end

    def discard_1(); :discard; end
    def discard_2(); :discard; end
  end

  class Parent
    def foo; end
    def self.class_method
      "I am #{name}"
    end
  end

  class Child1 < Parent; end
  class Child2 < Parent; end

  class A
    def baz(a, b)
      return [__FILE__, self.class]
    end
  end

  class B < A
  end

  class C < B
  end
end
