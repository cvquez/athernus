# frozen_string_literal: true

# This class is used to create a drag and drop file input
# It is used in the form to create a new question
class DragAndDropInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    content = placeholder_text || default_placeholder
    @builder.drag_and_drop_file_field(attribute_name, content, merged_input_options)
  end

  private

  def default_placeholder
    icon = content_tag(:i, nil, data: { feather: 'upload' })
    text = content_tag(:span, raw('<strong>Click para subir</strong> o arrastrar y soltar'))
    content_tag(:div, icon + text, class: 'd-flex align-items-center justify-content-center flex-column')
  end

end
