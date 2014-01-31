module Spring
  module Commands
    class Unicorn
      def env(args)
        "development"
      end

      def exec_name
        "unicorn"
      end

      def description
        "start unicorn server."
      end
    end
    Spring.register_command "unicorn", Unicorn.new
  end
end
