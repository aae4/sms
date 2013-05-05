# encoding: utf-8
class MessagesController < ApplicationController
  before_filter :authenticate_service!#, :except => [:show, :index]

  def index
    @per_page = params[:per_page] || 2
    @messages = Message.reversed_order(current_service.id).paginate(:page => params[:page], :per_page => @per_page)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  def new
    @message = Message.new
    @service = current_service
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  def edit
    @message = Message.find(params[:id])
    @custom_recipients = @message.custom_recipients.gsub("|", ", ")
  end


  def send_msg
    m = Message.find(params[:id])
    out = 'Сообщение было успешно отправлено.'
    # 
    m.users.each do |u|
      output = `echo #{m.body} | gnokii --sendsms #{u.phone}`
      #output = Kernel.send(:`, "echo #{m.body} | gnokii --sendsms #{u.phone}")
      #if output.split("\n")[0] != "AT+CMGS=52"
      if output.size == 0
        logger.info("1-----------#{u.phone}---------------")
        out = "Ваше сообщение не было отправлено или было отправлено не всем адресатам"
        #out = output
      end
    end
    m.groups.each do |g|
      g.users.each do |u|
        output = `echo #{m.body} | gnokii --sendsms #{u.phone}`
        #output = Kernel.send(:`, "echo #{m.body} | gnokii --sendsms #{u.phone}")
        #if output.split("\n")[0] != "AT+CMGS=52"
        if output.size == 0
          logger.info("2-----------#{u.phone}---------------")
          out = "Ваше сообщение не было отправлено или было отправлено не всем адресатам"
        end
      end
    end
    m.custom_recipients.split("|").each do |phone|
      #output = Kernel.send(:`, "echo #{m.body} | gnokii --sendsms #{phone}")
      output = `echo #{m.body} | gnokii --sendsms #{phone}`
      #if output.split("\n")[0] != "AT+CMGS=52"
      if output.size == 0
        logger.info("3-----------#{phone}---------------")
        out = "Ваше сообщение не было отправлено или было отправлено не всем адресатам"
      end
    end
    if out == 'Сообщение было успешно отправлено.'
      redirect_to messages_url, notice: out#notice: 'Сообщение было успешно отправлено.'
    else
      redirect_to messages_url, :flash => {:error => out}
    end
  end

  def create
    params[:message][:custom_recipients] = params[:message][:custom_recipients].gsub(/, ?/, "|")
    @message = Message.new(params[:message])
    custom_recipients = params[:custom_recipients] || []
    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @message = Message.find(params[:id])
    if params[:message][:group_ids].blank?
      params[:message][:group_ids] = []
    end
    if params[:message][:user_ids].blank?
      params[:message][:user_ids] = []
    end
    params[:message][:custom_recipients] = params[:message][:custom_recipients].gsub(/, ?/, "|")
    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end
