class PagesController < ApplicationController
  def home
  end

  def new
    @shakespeare_analyzer = ShakespeareAnalyzer.new
  end

  def create
    @shakespeare_analyzer = ShakespeareAnalyzer.new(analyzer_params)
  end


  private

    def analyzer_params
        params.require(:shakespeare_analyzer).permit(:url).permit(:totals).permit(:count)
    end

end
