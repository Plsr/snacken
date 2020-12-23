require 'json'

# Creates a url encoded json payload that will open
# things.app and create a new project for the passed shopping
# list.
# See https://culturedcode.com/things/support/articles/2803573/
class ThingsJsonService
  def initialize(shopping_list, meal_plan_date)
    @shopping_list = shopping_list
    @meal_plan_date = meal_plan_date
  end

  def build_link
    pp project_json
    raw_string = "things:///json?data=#{project_json}"
    url_encode(raw_string)
  end

  def todo_json
    ingredients_todos = []
    @shopping_list.shopping_list_ingredients.each do |ingr|
      title = "#{ingr.ingredient.name} (#{ingr.amount.join(' ')})"
      ingredients_todos << {
        type: 'to-do',
        attributes: {
          title: title
        }
      }
    end
    ingredients_todos
  end

  def project_json
    [{ type: 'project',
      attributes: {
        title: "Shopping List #{@meal_plan_date}",
        items: todo_json
      }
    }].to_json
  end

  def url_encode(payload)
    lib_encode = URI.encode(payload)

    # Since URI.encode will not replace square brackets,
    # we'll have to do that by hand.
    lib_encode.gsub("[","%5B").gsub("]","%5D")
  end
end
