class RedirectsController < ApplicationController
    def redirect_to_confirm
      # リダイレクト先のベースURL（外部ホスト）を設定
      base_url = "http://localhost:8000"
  
      # リダイレクト先のパスを設定（サブディレクトリを含む場合はここに設定）
      redirect_path = "/confirmation_success"
  
      # クエリパラメータを保持するためにparamsをmergeする
      redirect_url = "#{base_url}#{redirect_path}?#{request.query_string}"
  
      # リダイレクト
      redirect_to redirect_url, allow_other_host: true
    end

    def redirect_to_reset
        # リダイレクト先のベースURL（外部ホスト）を設定
        base_url = "http://localhost:8000"
    
        # リダイレクト先のパスを設定（サブディレクトリを含む場合はここに設定）
        redirect_path = "/reset"
    
        # クエリパラメータを保持するためにparamsをmergeする
        redirect_url = "#{base_url}#{redirect_path}?#{request.query_string}"
    
        # リダイレクト
        redirect_to redirect_url, allow_other_host: true
      end
  end