module Spree
  module Admin
    class StyleGuideController < Spree::Admin::BaseController
      respond_to :html
      layout '/spree/layouts/admin_style_guide'

      def index
        @topics = {
          visuals: [
            'colors',
          ],
          typography: [
            'headings',
            'body_text',
            'lists',
            'tags'
          ],
          forms: [
            'labels',
            'text_fields_boxes',
            'dropdowns',
            'select2_dropdowns',
            'radio_buttons',
            'checkboxes',
            'buttons'
          ],
          navigation: [
            'menu'
          ],
          layout: [
            'header',
            'footer'
          ]
        }
      end
    end
  end
end
