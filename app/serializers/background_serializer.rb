class BackgroundSerializer
  include FastJsonapi::ObjectSerializer

  attributes :bing_logo,
              :microsoft_privacy_agreement,
              :image,
              :width,
              :height,
              :host_page,
              :host_page_display,
              :date_published

end
