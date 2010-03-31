# Intervention

Intervention gives you a number of handy FormBuilder methods to make handling relationships within your forms easier.

## Easy Drop Downs

Ugly, out of fashion, and unhip:

    <%= form.select :country, [Country.new(:name => "Outer Space")] + Country.find(:all) %>
    <%= form.select :plan, Plan.order(:name).free.all %>
    <%= form.select :priority, controller.current_user.account.priorities.all %>

New, stylish, and clean:

    <%= form.select_field :country, :from => :eu_countries, :include_blank => "Outer Space" %>
    <%= form.select_field :plan, :type => :free %>
    <%= form.select_field :priority %>

The :from attribute defines a method name which returns the array selections to use. These can be name/value pairs as a Hash, as a nested Array, or as any object which responds to #name and #id. The :from attribute defaults to the underscored version of the class name of the relationship, if there is one.

Dropdowns are defined in the file lib/dropdowns.rb. Any options passed to select_field are also passed to the corresponding method in this class.

    class Dropdowns < Intervention::Dropdowns

      def eu_countries(options = {})
        Rails.cache("eu_countries_by_name") { Country.order(:name).eu.all }
      end

      def plans(options = {})
        if options.delete(:type) == :free
          Plan.order(:name).free.all
        else
          Plan.order(:name).all
        end
      end

      def priorities
        controller.current_user.account.priorities.all
      end
  
    end

Why? Its damn easy to test, great for re-use, easily cacheable, and your views won't be littered with as much confusing ERB code.

### Easy Arrays

Almost every application we make has some kind of expandable list. "Add Another", "Remove This", its all very repetitive.

    <% form.field_array_for :tasks, :blank => 1 do |task| %>
      <%= task.text_field :name %>
      <%= task.select_field :priority %>
      <%= task.delete_link "Remove This" %>
    <% end %>

This helper renders all existing tasks, and provides the ability to add another one, and even gives you a blank one for free.
