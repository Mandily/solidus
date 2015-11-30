module Spree
  module Admin
    class StyleGuideController < Spree::Admin::BaseController
      respond_to :html
      layout '/spree/layouts/admin_style_guide'

      def index
        @topics = {
          visuals: [
            'colors',
            'icons',
            'thumbnails'
          ],
          typography: [
            'headings',
            'lists',
            'tags'
          ],
          forms: [
            'labels',
            'text_fields_boxes',
            'dropdowns',
            'radio_buttons',
            'checkboxes',
            'buttons'
          ],
          messaging: [
            'client_side_form_field_validation',
            'server_side_form_error',
            'progress_bar',
            'flashes',
            'tooltips'
          ],
          layout: [
            'grid',
            'header',
            'footer',
            'tables'
          ],
          navigation: [
            'menu',
            'table_sorting',
            'table_pagination'
          ]
        }
      end
    end
  end
end
