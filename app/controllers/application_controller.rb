class ApplicationController < ActionController::Base
  # ********** 以下を追加 **********
  # 全ページをログイン必須とする
  before_action :authenticate_user!
  # ********** 以上を追加 **********
end
