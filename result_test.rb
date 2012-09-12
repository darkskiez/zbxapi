#require 'zbxapi.rb'

#$server="http://192.168.166.10"
#$api_user="apitest"
#$api_pass="apitest"

#zbx_api = ZabbixAPI.new($server)
#zbx_api.login($api_user,$api_pass)
#
#result=zbx_api.host.get({"output"=>"extend"})
#p result
#p result.fields
#p result.method_called
#p result.params

#class A
#  def method_missing(sym,*args)
#    p sym
#    A.new
#  end
#end
#
#a=A.new
#
#p a.test
#p a.test.two

#class Base
#  @dyn_methods={}
#  @dyn_keys=[]
#
#  def method_missing(sym,*args)
#    p sym
#
#    if self.class.dkeys.index(sym)
#      self.class.dmethods[sym].call
##      self.class.dmethods[sym].call(args)
#    else
#      super(sym,args)
#    end
#  end
#
#  def self.dmethods
#    @dyn_methods
#  end
#  def self.addmethod(sym,block)
#    @dyn_methods={} if @dyn_methods.nil?
#    @dyn_methods.merge!({sym=>block})
#    @dyn_keys=@dyn_methods.keys
#  end
#
#  def self.dkeys
#    @dyn_keys
#  end
#
#  def self.create_method(sym, &block)
#    self.addmethod(sym,block)
#  end
#
#  def func
#    puts "my function"
#  end
#end
#
#class C<Base
#end
#
#Base.create_method(:base_test) do
#  puts "Base"
#end
#
#C.create_method :mytest do
#  puts "test"
#end
#
#C.create_method :mytest2 do
#  puts "test2"
#  func
#end
#
#Base.new.base_test
#
#C.new.mytest
#C.new.mytest2


class Base
  def self.create_method(sym,&block)
    define_method(sym,&block)
  end

  def func
    puts "Base func"
  end
end

class A<Base
  def func
    puts "A Func"
  end
end

Base.create_method(:base_test) do
  puts "Base"
end

Base.create_method(:mytest) do
  puts "Base mytest"
end

Base.create_method(:mytest2) do
  puts "Base mytest2"
  func
end

A.create_method :mytest do
  puts "A mytest"
end

A.create_method :mytest2 do
  puts "A mytest2"
  func
end

Base.new.base_test
Base.new.mytest
Base.new.mytest2

A.new.mytest
A.new.mytest2
