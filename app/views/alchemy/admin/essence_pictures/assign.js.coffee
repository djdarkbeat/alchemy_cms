$('#picture_to_assign_<%= @picture.id %> a').attr('href', '#').off 'click'
$('#<%= content_dom_id(@content) -%>').replaceWith('<%= escape_javascript(
  render(
    partial: "alchemy/essences/essence_picture_editor",
    locals: {content: @content, options: @options}
  )
) -%>')
$('#element_<%= @element.id %>').trigger('Alchemy.PictureChange', [<%= @content.id %>, '<%= @preview_url.html_safe %>'])
<% if @content.siblings.essence_pictures.count > 1 %>
Alchemy.SortableContents '#<%= @content.element.id -%>_contents', '<%= form_authenticity_token -%>'
<% end %>
Alchemy.closeCurrentWindow()
Alchemy.setElementDirty '#element_<%= @content.element.id -%>'
Alchemy.overlayObserver '#<%= content_dom_id(@content) %>'
