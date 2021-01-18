class Background
  attr_reader :bing_logo,
              :microsoft_privacy_agreement,
              :image,
              :width,
              :height,
              :host_page,
              :host_page_display,
              :date_published,
              :id

  def initialize(data)
    @image = data[:value][0][:contentUrl]
    @width = data[:value][0][:width]
    @height = data[:value][0][:height]
    @host_page = data[:value][0][:hostPageUrl]
    @host_page_display = data[:value][0][:hostPageDisplayUrl]
    @date_published = data[:value][0][:datePublished]
    @microsoft_privacy_agreement = "https://go.microsoft.com/fwlink/?LinkId=521839"
    @bing_logo = "https://static.wikia.nocookie.net/logopedia/images/e/ee/Bing_2016.svg/revision/latest/scale-to-width-down/1000?cb=20160115161107"
  end
end
