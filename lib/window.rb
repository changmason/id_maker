require File.join(File.dirname(__FILE__), "worker.rb")

java_import javax.swing::JPanel
java_import javax.swing::JLabel
java_import javax.swing::JComboBox
java_import javax.swing::ButtonGroup
java_import javax.swing::JRadioButton
java_import javax.swing::JButton
java_import javax.swing::GroupLayout
class InputPanel < JPanel
  attr_reader :loc, :sex, :button
  
  def initialize
    super()
    area_list = IdMaker::AREA.to_a.map{|x| "(#{x[0]}) #{x[1]}"}
    area_list.unshift("(A) 天龍國")

    # construct ui components
    l1 = JLabel.new("產地:")
    cb = JComboBox.new(area_list.to_java)
    l2 = JLabel.new("性別:")
    group = ButtonGroup.new
    group.add(rb1 = JRadioButton.new("男", true))
    group.add(rb2 = JRadioButton.new("女", false))
    button = JButton.new("產生")
    
    # add event handlers
    cb.add_action_listener { |evt|
      @loc = evt.get_source.get_selected_item[/[A-Z]/] }
    rb1.add_action_listener { @sex = 1 if rb1.selected? }
    rb2.add_action_listener { @sex = 2 if rb2.selected? }
    
    # assign attributes
    @loc, @sex, @button = "A", 1, button
    
    set_layout(layout = GroupLayout.new(self))
    layout.set_horizontal_group(
      layout.create_parallel_group().
      add_group(layout.create_sequential_group().
        add_component(l1, 32, 32, 32).
        add_component(cb, 100, 100, 100)).
      add_group(layout.create_sequential_group().
        add_component(l2, 32, 32, 32).
        add_component(rb1, 44, 44, 44).
        add_component(rb2, 44, 44, 44)).
      add_group(layout.create_sequential_group().
       add_component(button, 128, 128, 128)))
        
    layout.set_vertical_group(
      layout.create_sequential_group().
      add_group(layout.create_parallel_group().
        add_component(l1, 28, 28, 28).
        add_component(cb, 26, 26, 26)).
      add_group(layout.create_parallel_group().
        add_component(l2, 28, 28, 28).
        add_component(rb1).
        add_component(rb2)).
      add_group(layout.create_parallel_group().
        add_component(button, 32, 32, 32)))
  end
  
  def add_comps(*args)
    args.each { |comp| add(comp) }
  end
  
  def enable
    get_components.to_a.each { |c| c.set_enabled(true) }
  end
  
  def disable
    get_components.to_a.each { |c| c.set_enabled(false) }
  end
end


# # #
java_import java.awt::Font
java_import java.awt::Insets
java_import javax.swing::JTextArea
class OutputPanel < JPanel
  def initialize
    super()
    @textarea = JTextArea.new(6, 7)
    @textarea.margin = Insets.new(5, 5, 5, 5)
    @textarea.font = Font.new("Arial", Font::BOLD, 18)
    @textarea.line_wrap = true
    add(@textarea)    
  end
  
  def clear
    @textarea.set_text("")
  end
  
  def append(string)
    @textarea.append(string)
  end
end


# # #
java_import javax.swing::UIManager
java_import javax.swing::JFrame
java_import javax.swing::BoxLayout

UIManager.set_look_and_feel(
  UIManager.get_system_look_and_feel_class_name)
class Window < JFrame
  def initialize
    super("身分證字號產生器")
    set_size(160, 270)
    set_resizable(false)
    set_layout(BoxLayout.new(get_content_pane, BoxLayout::Y_AXIS))
    set_default_close_operation(EXIT_ON_CLOSE)

    add(@input_panel = InputPanel.new)
    add(@output_panel = OutputPanel.new)
    
    @input_panel.button.add_action_listener do
      @input_panel.disable
      @output_panel.clear
      Worker.new(@input_panel, @output_panel).execute
    end
    
    self.visible = true
  end
end