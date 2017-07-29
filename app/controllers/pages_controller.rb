class PagesController < ApplicationController
  def home
  end

  def new
    @shakespeare_analyzer = ShakespeareAnalyzer.new
  end

  # logic of getting the results data is here after creating an instance of the analyzer.
  # results then get passed to partial

  def create
    @shakespeare_analyzer = ShakespeareAnalyzer.new(analyzer_params)
    @url = @shakespeare_analyzer.url
    @results = @shakespeare_analyzer.parse_count_sort(@shakespeare_analyzer.get_speakers(@url), @url)
    render(:partial => 'results', locals: {results: @results})
  end


  private

    def analyzer_params
        params.require(:shakespeare_analyzer).permit(:url, :totals, :speakers)
    end

end
