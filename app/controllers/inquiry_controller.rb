class InquiryController < ApplicationController
  #問い合わせフォーム
  def index
    @inquiry = Inquiry.new
    render :action => 'index'
  end

  #確認画面
  def confirm
    # 入力値のチェック
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    if @inquiry.valid?
      # 完了→確認画面を表示
      render :action => 'confirm'
    else
      # 不可→入力画面を再表示
      render :action => 'index'
    end
  end
  
  #問い合わせ送信完了
  def thanks
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))    
    InquiryMailer.received_email(@inquiry).deliver
    # 完了画面へ遷移
    render :action => 'thanks'
  end
end
