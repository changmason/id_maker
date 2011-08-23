require File.join(File.dirname(__FILE__), "id_maker.rb")

class Worker < javax.swing::SwingWorker

  def initialize(input, output)
    @input, @output = input, output
    super()
  end
  
  def doInBackground
    5.times { publish IdMaker.generate(@input.loc, @input.sex) }
  end
  
  def process(chunks)
    chunks.each { |chunk| @output.append(chunk) }
  end

  def done
    @input.enable
  end
end