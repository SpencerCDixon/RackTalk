class Example
  def initialize
    @secret = 99
  end

  def greeting
    "hello world"
  end
end

k = Example.new
k.instance_eval { @secret }   #=> 99
k.instance_eval { greeting }  #=> "hello world"
