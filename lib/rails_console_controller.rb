class RailsConsoleController < ActionController::Base
  
  before_filter :allowed_request?
  
  append_view_path([File.join(RAILS_ROOT,'vendor/plugins', 'rails_console', 'views')])
  
  layout nil  
  
  def index
    
  end
  
  def execute
    command = params[:command]
    command = white_list_command(command)
    
    unless command
      @result = "Invalid Command."
    else
      @result = eval(command) # => Magic happens here
    end
    
    respond_to do |wants|
      wants.html {  }
      wants.js {
        render :update do |page|
          page['result'].insert simple_format(h(@result.inspect))
        end
      }
    end
    
  rescue Exception => e
    respond_to do |wants|
      wants.html { render :text => e.backtrace, :layout => nil }
      wants.js {
        render :update do |page|
          page['result'].insert sanitize(simple_format(h(e.backtrace)))
        end
        
      }
    end
  
  end

private

  ##
  # Check if we have a valid request here
  def allowed_request?
    true
  end

  ##
  # White list the command
  def white_list_command(command)

    # do the white list here
    command
  end

  
end
