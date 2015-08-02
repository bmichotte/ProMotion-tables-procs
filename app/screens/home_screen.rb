class HomeScreen < PM::TableScreen
  title "Your title here"
  stylesheet HomeScreenStylesheet

  def on_load
    set_nav_bar_button :left, system_item: :camera, action: :nav_left_button
    set_nav_bar_button :right, title: "Reload", action: :nav_right_button

    @hello_world = append!(UILabel, :hello_world)
  end

  def nav_left_button
    mp 'Left button'
  end

  def nav_right_button
    update_table_data
  end

  def table_data
    @number ||= 0
    [{
       cells: (0..2000).map do |line|
         @number += 1
         {
           title: "line #{@number}",
           action: -> (args, index_path) {
             mp args: args, index_path: index_path
             app.alert title: 'Hello',
                       message: "Tapped on line #{args[:line]}"
           },
           arguments: { line: @number }
         }
       end
     }]
  end

  # You don't have to reapply styles to all UIViews, if you want to optimize, another way to do it
  # is tag the views you need to restyle in your stylesheet, then only reapply the tagged views, like so:
  #   def logo(st)
  #     st.frame = {t: 10, w: 200, h: 96}
  #     st.centered = :horizontal
  #     st.image = image.resource('logo')
  #     st.tag(:reapply_style)
  #   end
  #
  # Then in will_animate_rotate
  #   find(:reapply_style).reapply_styles#

  # Remove the following if you're only using portrait
  def will_animate_rotate(orientation, duration)
    find.all.reapply_styles
  end
end
