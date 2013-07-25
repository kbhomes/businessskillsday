module ApplicationHelper
  def active_action?(controller, action)
    controller ||= controller_name
    action ||= action_name

    if controller.is_a? String
      controller = [controller]
    end

    if action.is_a? String
      action = [action]
    end

    'active' if controller.include?(controller_name) && action.include?(action_name)
  end

  def sidebar_header(*args)
    name = args.first
    options = args.second || {}
    icon = options[:icon]

    icon_class = "<i class=\"#{icon}\"></i> ".html_safe if icon
    "<li class=\"nav-header\">#{icon_class}#{name}</li>".html_safe
  end

  def sidebar_link(*args)
    name = args.first
    path = args.second
    options = args.third || {}

    active_class = 'class="active"' if active_action?(options[:controller], options[:action])
    link = link_to name, path
    "<li #{active_class}>#{link}</li>".html_safe
  end

  def icon_title(icon, title)
    "<i class='icon-#{icon}'></i> #{title}".html_safe
  end

  def icon_title_new(title = 'New')
    icon_title 'plus', title
  end

  def icon_title_edit(title = 'Edit')
    icon_title 'pencil', title
  end

  def icon_title_delete(title = 'Delete')
    icon_title 'remove', title
  end

  def icon_title_info(title)
    icon_title 'info', title
  end

  def icon_title_question(title)
    icon_title 'question', title
  end

  def icon_title_exclamation(title)
    icon_title 'exclamation', title
  end

  def icon_title_student(title)
    icon_title 'user', title
  end

  def icon_title_team(title)
    icon_title 'group', title
  end

  def icon_title_adviser(title)
    icon_title 'legal', title
  end

  def icon_title_chapter(title)
    icon_title 'flag', title
  end

  def icon_title_event(title)
    icon_title 'calendar', title
  end

  def icon_title_account(title)
    icon_title 'cog', title
  end

  def icon_title_result(title)
    icon_title 'trophy', title
  end

  #def link_to_new(type, url, options = {})
  #  link_to url, { :class => 'btn btn-mini btn-success' }.merge(options) do
  #    "<i class='icon-plus'></i> New #{type.humanize}".html_safe
  #  end
  #end
  #
  #def link_to_edit(url, options = {})
  #  link_to url, { :class => 'btn btn-mini' }.merge(options) do
  #    "<i class='icon-edit'></i> Edit".html_safe
  #  end
  #end
  #
  #def link_to_delete(url, options = {})
  #  link_to url, { :class => 'btn btn-mini btn-danger' }.merge(options) do
  #    "<i class='icon-remove'></i> Delete".html_safe
  #  end
  #end

  def link_to_new(object, url, options = {})
    klass = case object
              when Class then object
              else            object.class
            end

    if can? :create, klass
      link_to url, { :class => 'btn btn-mini btn-success' }.merge(options) do
        "<i class='icon-plus'></i> New #{klass.name.humanize}".html_safe
      end
    end
  end

  def link_to_edit(object, url, options = {})
    if can? :update, object
      link_to url, { :class => 'btn btn-mini' }.merge(options) do
        "<i class='icon-edit'></i> Edit".html_safe
      end
    end
  end

  def link_to_delete(object, url, options = {})
    if can? :destroy, object
      link_to url, { :class => 'btn btn-mini btn-danger' }.merge(options) do
        "<i class='icon-remove'></i> Delete".html_safe
      end
    end
  end
end
