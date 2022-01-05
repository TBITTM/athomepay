class AccountActivitiesController < ApplicationController
   before_action :require_user_logged_in
   
  def index
    @accountactivity = current_user.account_activities.order(id: :desc)
  end
   
  def new
    @accountactivity = AccountActivity.new
  end

  def show
    @accountactivity = AccountActivity.find(params[:id])
  end
  
  
  def create
    
    give = params[:commit] == 'あげる（増やす場合はこちら）'
    
    @accountactivity = current_user.account_activities.new(account_activity_params)
    if give
      @accountactivity.give_take = 'あげる'
      @accountactivity.balance = current_user.balance + @accountactivity.price
    else
      @accountactivity.give_take = 'へらす'
      @accountactivity.balance = current_user.balance - @accountactivity.price
    end
    if @accountactivity.save
      current_user.update(balance: @accountactivity.balance)
      flash[:success] = '取引が正常に保存されました'
      redirect_to @accountactivity
    else
      flash.now[:danger] = '取引が保存されませんでした'
      render :new
    end
  end
  
  
  
  def history 
    @pagy, @history = pagy(AccountActivity.order(id: :desc), items: 15)
  end
  
  def destroy 
    
    @history = AccountActivity.find(params[:id])
    
    if  @history.give_take == 'あげる'
      current_user.update(balance: current_user.balance - @history.price)
      current_user.account_activities.where("id>?",params[:id]).each do | h |
        h.update(balance: h.balance - @history.price)
      end
      
    else 
      current_user.update(balance: current_user.balance + @history.price)
      current_user.account_activities.where("id>?",params[:id]).each do | h |
        h.update(balance: h.balance + @history.price)
      end
    end

     @history.destroy#通常の削除
    flash[:success] = '履歴は正常に削除されました。最終残高が変更されます。'
    redirect_to history_account_activities_url
    #ほかの一覧の金額変更?
  end


  def account_activity_params
    params.require(:account_activity).permit(:remarks, :price, :give_take, :balance)
  end
  
end