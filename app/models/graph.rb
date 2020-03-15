class Graph < ApplicationRecord
  belongs_to :user
  # 一人のユーザーが同じ日付のデータを複数記録できないようにする
  validates :date, presence: true, uniqueness: { scope: :user_id }
  validates :weight, presence: true

  # そのままデータを取り出すと，日付が不連続なデータになるため，日付の連続したデータを作成する。
  def self.chart_data(user)
    graphs = user.graphs.order(date: :asc)
    # 記録が無い場合にエラーが出るのを防止
    return [{ date: Date.today, weight: nil }] if graphs.empty?

    period = graphs[0].date..graphs[-1].date
    # 記録の初日から最終日までの配列データを作成
    index = 0
    period.map do |date|
      if graphs[index].date == date
        weight = graphs[index].weight
        index += 1
      end
      # データが存在しない日付の体重は nil とする。
      { date: date, weight: weight }
    end
  end
end
