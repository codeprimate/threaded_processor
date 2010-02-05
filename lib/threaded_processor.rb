# ThreadedProcessor : A very simple wrapper for sized queue multithreading with Ruby
# 
# = Usage
# 
#   object_list = %w(1..100).to_a
#   threads = 5
#   tp = ThreadedProcessor.new(object_list,threads) do |obj|
#     puts obj
#   end
#   tp.run!
# 
# OR
# 
#   tp = ThreadedProcessor.new
#   tp.list = [1,2,3]
#   tp << 4
#   tp << 5
#   tp.block = Proc.new{|x| puts x}
#   tp.max_threads = 5
#   tp.run!


VERSION = "0.1.1"

require 'thread'

class ThreadedProcessorError < StandardError; end

class ThreadedProcessor
  attr_accessor :list, :max_threads, :block
  
  # Provide an object list array, thread count (Integer), 
  # and a block to run
  def initialize(object_list=[], thread_count=3, &block)
    @list = object_list
    @max_threads = thread_count
    @queue = Queue.new
    @block = block
    self
  end
  
  # Append an item to the object list
  def <<(obj)
    @list << obj
  end
  
  # Empty the object list
  def empty!
    @list = []
  end
  
  # Run the multithreaded process.
  def run!
    raise ThreadedProcessorError.new("Object list is empty!") if (@list.empty? || !@list.is_a?(Array))
    raise ThreadedProcessorError.new("Assign block") if @block.nil?
    threads = (1..@max_threads).map do |i|
     Thread.new(@queue) do |q|
       until ( q == ( obj = q.deq ) )
         @block.call(obj)
       end
     end
    end
    @list.each{|o| @queue.enq o}
    threads.size.times{@queue.enq @queue}
    threads.each{|t| t.join}
    true
  end
end

