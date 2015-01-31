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
    class UnicornRails
      def env(args)
        "development"
      end

      def exec_name
        "unicorn_rails"
      end

      def description
        "start unicorn_rails server."
      end
    end
    Spring.register_command "unicorn_rails", UnicornRails.new
  end
end
