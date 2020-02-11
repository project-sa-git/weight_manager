class GraphsController < ApplicationController
  def index
    gon.weight_records = Graph.chart_data(current_user)
  # ********** 以下を追加 **********
    # 記録済みの日付データ
    gon.recorded_dates = current_user.graphs.map(&:date)
  # ********** 以上を追加 **********
  end

  def create
  # ********** 以下を追加 **********
    @graph = current_user.graphs.build(graph_params)
    date = @graph.date.strftime('%Y/%-m/%-d')
    if @graph.save
      flash[:notice] = "#{date}の記録を追加しました"
    else
      flash[:alert] = 'エラーが発生しました'
    end
    redirect_to root_path
  # ********** 以上を追加 **********
  end

  def update
    # ********** 以下を追加 **********
    @graph = current_user.graphs.find_by(date: params[:graph][:date])
    date = @graph.date.strftime('%Y/%-m/%-d')
    if @graph.nil?
      flash[:alert] = 'エラーが発生しました'
    elsif params[:_destroy].nil? && @graph.update(graph_params)
      flash[:notice] = "#{date}の記録を修正しました。"
    elsif params[:_destroy].present? && @graph.destroy
      flash[:alert] = "#{date}の記録を削除しました。"
    else
      flash[:alert] = 'エラーが発生しました'
    end
    redirect_to root_path
    # ********** 以上を追加 **********
  end
  # ********** 以下を追加 **********
  private

  def graph_params
    params.require(:graph).permit(:date, :weight)
  end
  # ********** 以上を追加 **********
end
