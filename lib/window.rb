require File.join(File.dirname(__FILE__), "worker.rb")

java_import javax.swing::JPanel
java_import javax.swing::JLabel
java_import javax.swing::JComboBox
java_import javax.swing::ButtonGroup
java_import javax.swing::JRadioButton
java_import javax.swing::JButton

class InputPanel < JPanel
  attr_reader :loc, :sex, :button
  
  def initialize
    super()
    area_list = IdMaker::AREA.to_a.map{|x| "(#{x[0]})#{x[1]}"}
    area_list.unshift("(A)天龍國")

    # construct ui components
    l1 = JLabel.new("產地:")
    cb = JComboBox.new(area_list.to_java)
    l2 = JLabel.new("性別:")
    group = ButtonGroup.new
    group.add(rb1 = JRadioButton.new("男", true))
    group.add(rb2 = JRadioButton.new("女", false))
    button = JButton.new("產生")
    
    # add event handlers
    cb.add_action_listener do |evt| 
      @loc = evt.get_source.get_selected_item[/[A-Z]/]
    end
    rb1.add_action_listener { @sex = 1 if rb1.selected? }
    rb2.add_action_listener { @sex = 2 if rb2.selected? }
    
    # assign attributes
    @loc, @sex, @button = "A", 1, button
    add_components(l1, cb, l2, rb1, rb2, button)
  end
  
  def add_components(*args)
    args.each { |comp| add(comp) }
  end
  
  def enable
    get_components.to_a.each do |c| c.set_enabled(true) end
  end
  
  def disable
    get_components.to_a.each do |c| c.set_enabled(false) end
  end
end

class OutputPanel < JPanel
  def initialize
    super()
  end
end

# # #
java_import javax.swing::JFrame

class Window < JFrame
  attr_reader :input_panel, :output_panel
  
  def initialize
    super("身分證字號產生器")
    
    @input_panel = InputPanel.new
    @output_panel = OutputPanel.new
    
    @input_panel.disable

    add(@input_panel)
    add(@output_panel)
    
    self.set_size(160, 250)
    self.set_location_relative_to(nil)
    self.set_default_close_operation(EXIT_ON_CLOSE)
  end
  
end

