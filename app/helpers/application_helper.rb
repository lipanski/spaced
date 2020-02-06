# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def pagy_prev_link(pagy, label = "« Newer", html: {})
    link = pagy_link_proc(pagy)
    pagy_prev = pagy.prev

    html =
      if pagy_prev
        link.call(pagy_prev, label, "class='#{html[:class]}'")
      else
        "<a class='#{html[:class]}' disabled>#{label}</a>"
      end

    html.html_safe
  end

  def pagy_next_link(pagy, label = "Older »", html: {})
    link = pagy_link_proc(pagy)
    pagy_next = pagy.next

    html =
      if pagy_next
        link.call(pagy_next, label, "class='#{html[:class]}'")
      else
        "<a class='#{html[:class]}' disabled>#{label}</a>"
      end

    html.html_safe
  end
end
