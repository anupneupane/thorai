module ActionController
  module MobileMode
    
    MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                          'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                          'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                          'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                          'webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|' +
                          'mobile'
                          
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      
      def mobile_mode(options = {})
        include InstanceMethods
      end
      
      def mobile_device?
        @@mobile_device
      end

      def mobile_view?
        @@mobile_view
      end

      def device?(type)
        @@device
      end
      
    end
    
    module InstanceMethods
      
      def force_mobile_format
        request.format = :mobile
        session[:mobile_view] = true if session[:mobile_view].nil?
      end

      def set_mobile_format
        if is_mobile_device? && !request.xhr?
          request.format = session[:mobile_view] == false ? :html : :mobile
          session[:mobile_view] = true if session[:mobile_view].nil?
        end
      end

      def mobile_view?
        request.format.to_sym == :mobile
      end

      def device?(type)
        request.user_agent.to_s.downcase.include?(type.to_s.downcase)
      end

      def mobile_device?
        puts "Detecting Mobile Device ........................................................"
        if session[:mobile_param]
          session[:mobile_param] == "1"
        else
          #request.user_agent =~ /Mobile|webOS/
          request.user_agent.to_s.downcase =~ Regexp.new(ActionController::MobileMode::MOBILE_USER_AGENTS)
        end
      end
   
    end
    
  end
end