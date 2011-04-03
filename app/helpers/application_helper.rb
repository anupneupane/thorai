module ApplicationHelper
  
  def title(page_title)
    content_for(:title){page_title}
  end
  
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end
  
  def home_index_showing?
    if params[:controller] == 'home' && params[:action] == 'index'
      true
    end
  end
  
end
