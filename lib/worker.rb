require File.join(File.dirname(__FILE__), "id_maker.rb")

class Worker < javax.swing::SwingWorker

  def initialize(input, output)
    super()
    @input, @output = input, output
  end
  
  def doInBackground
    5.times { sleep(0.5) and publish(IdMaker.generate(@input.loc, @input.sex)) }
  end
  
  def process(chunks)
    chunks.each { |chunk| @output.append(chunk + ", \n") }
  end

  def done
    @output.append("... done")
    @input.enable
  end
end