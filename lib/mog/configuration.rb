module Mog
  class Configuration
    def set(option_name, option_value)
      define_instace_variable(option_name, option_value)
      define_attr_reader_for(option_name)
    end

    def define_instace_variable(name, value)
      eval "@#{name} = value"
    end

    def define_attr_reader_for(option)
      Configuration.class_eval do
        define_method :"#{option}" do
          eval "@#{option}"
        end
      end
    end
  end
end
