require "java"
require File.join(File.dirname(__FILE__), "lib", "window.rb")

javax.swing::SwingUtilities.invoke_later do
  Window.new.visible = true
end